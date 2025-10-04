import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../core/model/movie_list_model.dart';
import '../../../../core/theme/my_text_theme.dart';

class MovieCard extends StatelessWidget {
  final Result movie;
  final VoidCallback? onPressed;

  const MovieCard({super.key, required this.movie, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 4, offset: const Offset(0, 2))],
        ),
        child: Row(
          children: [
            // Movie poster
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: CachedNetworkImage(
                imageUrl: movie.posterPath != null
                    ? "https://image.tmdb.org/t/p/w200${movie.posterPath}"
                    : "https://via.placeholder.com/150x200?text=No+Image",
                width: 80,
                height: 120,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  width: 80,
                  height: 120,
                  color: Colors.grey[300],
                  child: const Center(child: CircularProgressIndicator()),
                ),
                errorWidget: (context, url, error) => Container(width: 80, height: 120, color: Colors.grey[300], child: const Icon(Icons.error)),
              ),
            ),

            const SizedBox(width: 16),

            // Movie details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title ?? "Unknown Title",
                    style: MyTextTheme.myBodySmallTheme(fontSize: 16, fontWeight: FontWeight.bold, textColor: Colors.black87),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),

                  if (movie.overview != null && movie.overview!.isNotEmpty)
                    Text(
                      movie.overview!,
                      style: MyTextTheme.myBodySmallTheme(fontSize: 12, textColor: Colors.grey[600]),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),

                  const SizedBox(height: 8),

                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        movie.voteAverage?.toStringAsFixed(1) ?? "0.0",
                        style: MyTextTheme.myBodySmallTheme(fontSize: 14, textColor: Colors.black87),
                      ),
                      const SizedBox(width: 16),
                      Text(
                        movie.releaseDate?.year.toString() ?? "Unknown",
                        style: MyTextTheme.myBodySmallTheme(fontSize: 14, textColor: Colors.grey[600]),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
