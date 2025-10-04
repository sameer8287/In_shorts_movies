import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:go_router/go_router.dart';
import 'package:in_shorts_movies/core/utils/helper_function.dart';
import 'package:in_shorts_movies/feature/movies/presentation/widgets/movie_card.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';
import 'package:gap/gap.dart';
import '../../../../core/router/router_name.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/theme/my_text_theme.dart';
import '../provider/movie_list_provider.dart';

class BookmarkScreen extends StatefulWidget {
  const BookmarkScreen({super.key});

  @override
  State<BookmarkScreen> createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends State<BookmarkScreen> {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await getData();
    });
  }

  Future<void> getData() async {
    try {
      context.loaderOverlay.show();
      await context.read<MoviesListProvider>().getBookMarkedMovies();
    } catch (e) {
      HelperFunctions.showSnackBar(context, e.toString());
    } finally {
      context.loaderOverlay.hide();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.primaryColor,
        title: Text('Bookmarks', style: MyTextTheme.myBodySmallTheme(fontSize: 18, textColor: Colors.white)),
      ),
      body: Consumer<MoviesListProvider>(
        builder: (context, value, child) {
          if (value.bookMarkedMovies.isEmpty) return Center(child: Text("No data found"));
          return ListView.separated(
            padding: EdgeInsets.all(16),

            itemBuilder: (context, index) {
              final data = value.bookMarkedMovies[index];
              return MovieCard(
                movie: data,
                onPressed: () {
                  context.pushNamed(RouteName.movieDetails, queryParameters: {"id": data.id.toString()}).then((_) {
                    getData();
                  });
                },
              );
            },
            separatorBuilder: (context, index) => Gap(10),
            itemCount: value.bookMarkedMovies.length,
          );
        },
      ),
    );
  }
}
