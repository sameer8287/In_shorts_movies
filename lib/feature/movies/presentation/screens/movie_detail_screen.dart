import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:go_router/go_router.dart';
import 'package:in_shorts_movies/core/router/router_name.dart';
import 'package:in_shorts_movies/feature/movies/presentation/widgets/movie_detail_widget.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:share_plus/share_plus.dart';
import '../../../../core/utils/helper_function.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/theme/my_text_theme.dart';
import '../../../../core/model/movie_detail_model.dart';
import '../provider/movie_list_provider.dart';

class MovieDetailScreen extends StatefulWidget {
  final int id;

  const MovieDetailScreen({super.key, required this.id});

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
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
      await provider.getMovieDetail(widget.id);
    } catch (e, stacktrace) {
      HelperFunctions.printLog(e.toString(), stacktrace);
      HelperFunctions.showSnackBar(context, e.toString());
    } finally {
      context.loaderOverlay.hide();
    }
  }

  void _shareMovie(MovieDetailModel movie) {
    final String url = "https://sameer8287.github.io${RouteName.movieDetails}?id=${widget.id}";
    try {
      Share.shareUri(Uri.parse(url));
    } catch (e) {
      HelperFunctions.showSnackBar(context, e.toString());
    }
  }

  void _toggleBookmark() {
    if (!context.read<MoviesListProvider>().isBookMarked) {
      context.read<MoviesListProvider>().addBookMark(widget.id);
    } else {
      context.read<MoviesListProvider>().removeBookMark(widget.id);
    }
    HelperFunctions.showSnackBar(context, !context.read<MoviesListProvider>().isBookMarked ? 'Added to bookmarks' : 'Removed from bookmarks');
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: context.canPop(),
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop && !context.canPop()) {
          context.goNamed(RouteName.moviesList);
        }
      },
      child: Scaffold(
        body: Consumer<MoviesListProvider>(
          builder: (context, provider, child) {
            final movie = provider.movieDetail;

            if (movie == null) {
              return const Center(child: Text("No data found"));
            }

            return CustomScrollView(
              slivers: [
                // App Bar with movie banner
                _buildSliverAppBar(provider, movie),

                // Movie details content
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Movie title and rating
                        _buildMovieHeader(movie),
                        const SizedBox(height: 16),

                        // Movie details
                        MovieDetailWidget(movie: movie),
                        const SizedBox(height: 24),

                        // Genres
                        _buildGenresSection(movie),
                        const SizedBox(height: 24),

                        // Production companies
                        _buildProductionSection(movie),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildSliverAppBar(MoviesListProvider provider, MovieDetailModel movie) {
    return SliverAppBar(
      expandedHeight: 300,
      pinned: true,
      backgroundColor: AppTheme.primaryColor,
      actions: [
        // Bookmark button
        IconButton(
          onPressed: _toggleBookmark,
          icon: Icon(provider.isBookMarked ? Icons.bookmark : Icons.bookmark_border, color: Colors.white),
        ),
        // Share button
        IconButton(
          onPressed: () => _shareMovie(movie),
          icon: const Icon(Icons.share, color: Colors.white),
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            // Movie backdrop
            CachedNetworkImage(
              imageUrl: movie.backdropPath != null
                  ? "https://image.tmdb.org/t/p/w1280${movie.backdropPath}"
                  : "https://via.placeholder.com/1280x720?text=No+Image",
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

            // Movie poster overlay
            Positioned(
              bottom: 16,
              left: 16,
              right: 16,
              child: Row(
                children: [
                  // Movie poster
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: CachedNetworkImage(
                      imageUrl: movie.posterPath != null
                          ? "https://image.tmdb.org/t/p/w300${movie.posterPath}"
                          : "https://via.placeholder.com/200x300?text=No+Image",
                      width: 100,
                      height: 150,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        width: 100,
                        height: 150,
                        color: Colors.grey[300],
                        child: const Center(child: CircularProgressIndicator()),
                      ),
                      errorWidget: (context, url, error) =>
                          Container(width: 100, height: 150, color: Colors.grey[300], child: const Icon(Icons.error)),
                    ),
                  ),

                  const SizedBox(width: 16),

                  // Movie info overlay
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          movie.title ?? "Unknown Title",
                          style: MyTextTheme.myBodySmallTheme(fontSize: 24, fontWeight: FontWeight.bold, textColor: Colors.white),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 8),

                        if (movie.tagline != null && movie.tagline!.isNotEmpty)
                          Text(
                            movie.tagline!,
                            style: MyTextTheme.myBodySmallTheme(fontSize: 14, textColor: Colors.white70).copyWith(fontStyle: FontStyle.italic),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMovieHeader(MovieDetailModel movie) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title
        Text(
          movie.title ?? "Unknown Title",
          style: MyTextTheme.myBodySmallTheme(fontSize: 28, fontWeight: FontWeight.bold, textColor: Colors.black87),
        ),
        const SizedBox(height: 8),

        // Rating and release date
        Row(
          children: [
            Icon(Icons.star, color: Colors.amber, size: 20),
            const SizedBox(width: 4),
            Text(
              movie.voteAverage?.toStringAsFixed(1) ?? "0.0",
              style: MyTextTheme.myBodySmallTheme(fontSize: 16, fontWeight: FontWeight.bold, textColor: Colors.black87),
            ),
            const SizedBox(width: 8),
            Text("/ 10", style: MyTextTheme.myBodySmallTheme(fontSize: 14, textColor: Colors.grey[600])),
            const SizedBox(width: 16),
            Text("(${movie.voteCount ?? 0} votes)", style: MyTextTheme.myBodySmallTheme(fontSize: 14, textColor: Colors.grey[600])),
          ],
        ),
        const SizedBox(height: 8),

        // Release date and runtime
        Row(
          children: [
            if (movie.releaseDate != null)
              Text(movie.releaseDate!.year.toString(), style: MyTextTheme.myBodySmallTheme(fontSize: 16, textColor: Colors.black87)),
            if (movie.runtime != null && movie.runtime! > 0) ...[
              const SizedBox(width: 16),
              Text("${movie.runtime} min", style: MyTextTheme.myBodySmallTheme(fontSize: 16, textColor: Colors.black87)),
            ],
          ],
        ),
      ],
    );
  }

  Widget _buildGenresSection(MovieDetailModel movie) {
    if (movie.genres == null || movie.genres!.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Genres",
          style: MyTextTheme.myBodySmallTheme(fontSize: 20, fontWeight: FontWeight.bold, textColor: AppTheme.primaryColor),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: movie.genres!
              .map(
                (genre) => Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppTheme.primaryColor.withOpacity(0.3)),
                  ),
                  child: Text(genre.name ?? "Unknown", style: MyTextTheme.myBodySmallTheme(fontSize: 14, textColor: AppTheme.primaryColor)),
                ),
              )
              .toList(),
        ),
      ],
    );
  }

  Widget _buildProductionSection(MovieDetailModel movie) {
    if (movie.productionCompanies == null || movie.productionCompanies!.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Production Companies",
          style: MyTextTheme.myBodySmallTheme(fontSize: 20, fontWeight: FontWeight.bold, textColor: AppTheme.primaryColor),
        ),
        const SizedBox(height: 12),
        ...movie.productionCompanies!
            .map(
              (company) => Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Text("• ${company.name ?? 'Unknown'}", style: MyTextTheme.myBodySmallTheme(fontSize: 14, textColor: Colors.black87)),
              ),
            )
            .toList(),
      ],
    );
  }
}
