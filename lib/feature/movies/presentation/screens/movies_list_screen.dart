import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:go_router/go_router.dart';
import 'package:in_shorts_movies/core/router/router_name.dart';
import 'package:in_shorts_movies/core/services/sync_work_manager.dart';
import 'package:in_shorts_movies/core/utils/helper_function.dart';
import 'package:in_shorts_movies/core/widgets/custom_textformfield.dart';
import 'package:in_shorts_movies/feature/movies/presentation/provider/movie_list_provider.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/theme/my_text_theme.dart';
import '../../../../core/model/movie_list_model.dart';
import '../../../landing/presentation/provider/internet_connectivity_provider.dart';
import 'package:gap/gap.dart';

import '../widgets/movie_card.dart';

class MovieListScreen extends StatefulWidget {
  const MovieListScreen({super.key});

  @override
  State<MovieListScreen> createState() => _MovieListScreenState();
}

class _MovieListScreenState extends State<MovieListScreen> {
  final CarouselSliderController _carouselController = CarouselSliderController();
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await initData();
    });
  }

  Future<void> initData() async {
    final provider = context.read<MoviesListProvider>();
    try {
      context.loaderOverlay.show();
      await provider.initData();
    } catch (e, stacktrace) {
      HelperFunctions.printLog(e.toString(), stacktrace);
      HelperFunctions.showSnackBar(context, e.toString());
    } finally {
      context.loaderOverlay.hide();
    }
  }

  Future<void> syncAllData() async {
    try {
      context.loaderOverlay.show();
      final isInternet = context.read<InternetConnectivityProvider>().isInternetAvailable;
      if (isInternet) {
        await SyncWorkManager.instance.syncAllData();
      } else {
        HelperFunctions.showSnackBar(context, "No Internet Connection");
      }
    } catch (e, stacktrace) {
      HelperFunctions.printLog(e.toString(), stacktrace);
    } finally {
      context.loaderOverlay.hide();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.primaryColor,
        title: Text("Welcome", style: MyTextTheme.myBodySmallTheme(fontSize: 18, textColor: Colors.white)),
        actions: [
          Consumer<InternetConnectivityProvider>(
            builder: (context, value, child) {
              return GestureDetector(
                onTap: () async {
                  await syncAllData();
                  await initData();
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 14),
                  child: Badge(
                    backgroundColor: value.isInternetAvailable ? Colors.green : Colors.red,
                    child: Icon(Icons.sync, color: Colors.white),
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),

        child: Column(
          children: [
            Gap(10),
            CustomTextFormField(hintText: "Search Movie name", controller: searchController,
            onChanged: (value){

            },
            prefixIcon: Icon(Icons.search,color: Colors.grey,),
            ),
            Gap(15),
            Expanded(
              child: Consumer<MoviesListProvider>(
                builder: (context, provider, child) {
                  if (provider.nowPlayingMovies.isEmpty && provider.tendingMovies.isEmpty) {
                    return Center(
                      child: ElevatedButton(
                        style: ButtonStyle(backgroundColor: WidgetStateProperty.all(AppTheme.primaryColor)),

                        onPressed: () async {
                          await syncAllData();
                          await initData();
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.sync, color: Colors.white, size: 22),
                            Gap(15),
                            Text(
                              "Sync data",
                              style: MyTextTheme.myBodyMediumTheme(textColor: Colors.white, fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                  return SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Trending Movies Carousel Section
                        _buildTrendingMoviesSection(provider.tendingMovies),
                        const SizedBox(height: 32),

                        // Now Playing Movies Section
                        _buildNowPlayingMoviesSection(provider.nowPlayingMovies),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTrendingMoviesSection(List<Result> trendingMovies) {
    if (trendingMovies.isEmpty) {
      return const SizedBox.shrink();
    }

    final movies = trendingMovies;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Trending Movies",
          style: MyTextTheme.myBodySmallTheme(fontSize: 24, fontWeight: FontWeight.bold, textColor: AppTheme.primaryColor),
        ),
        const SizedBox(height: 16),
        CarouselSlider.builder(
          carouselController: _carouselController,
          itemCount: movies.length,
          itemBuilder: (context, index, realIndex) {
            final movie = movies[index];
            return _buildTrendingMovieCard(movie);
          },
          options: CarouselOptions(
            height: 300,
            viewportFraction: 1.0,
            enlargeCenterPage: false,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 3),
            onPageChanged: (index, reason) {
              // setState(() {
              //   _currentTrendingIndex = index;
              // });
            },
          ),
        ),
      ],
    );
  }

  Widget _buildTrendingMovieCard(Result movie) {
    return GestureDetector(
      onTap: () {
        context.pushNamed(RouteName.movieDetails, queryParameters: {"id": movie.id.toString()});
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 8, offset: const Offset(0, 4))],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Movie backdrop image
              CachedNetworkImage(
                imageUrl: movie.backdropPath != null
                    ? "https://image.tmdb.org/t/p/w500${movie.backdropPath}"
                    : "https://via.placeholder.com/500x300?text=No+Image",
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  color: Colors.grey[300],
                  child: const Center(child: CircularProgressIndicator()),
                ),
                errorWidget: (context, url, error) => Container(color: Colors.grey[300], child: const Icon(Icons.error, size: 50)),
              ),

              // Gradient overlay
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
                  ),
                ),
              ),

              // Movie info
              Positioned(
                bottom: 16,
                left: 16,
                right: 16,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      movie.title ?? "Unknown Title",
                      style: MyTextTheme.myBodySmallTheme(fontSize: 20, fontWeight: FontWeight.bold, textColor: Colors.white),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.amber, size: 16),
                        const SizedBox(width: 4),
                        Text(
                          movie.voteAverage?.toStringAsFixed(1) ?? "0.0",
                          style: MyTextTheme.myBodySmallTheme(fontSize: 14, textColor: Colors.white),
                        ),
                        const SizedBox(width: 16),
                        Text(
                          movie.releaseDate?.year.toString() ?? "Unknown",
                          style: MyTextTheme.myBodySmallTheme(fontSize: 14, textColor: Colors.white70),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNowPlayingMoviesSection(List<Result> nowPlayingMovies) {
    if (nowPlayingMovies.isEmpty) {
      return const SizedBox.shrink();
    }

    final movies = nowPlayingMovies;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Now Playing",
          style: MyTextTheme.myBodySmallTheme(fontSize: 24, fontWeight: FontWeight.bold, textColor: AppTheme.primaryColor),
        ),
        const SizedBox(height: 16),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: movies.length,
          itemBuilder: (context, index) {
            final movie = movies[index];
            return MovieCard(
              movie: movie,
              onPressed: () {
                context.pushNamed(RouteName.movieDetails, queryParameters: {"id": movie.id.toString()});
              },
            );
          },
        ),
      ],
    );
  }
}
