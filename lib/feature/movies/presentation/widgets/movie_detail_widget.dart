import 'package:flutter/material.dart';

import '../../../../core/model/movie_detail_model.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/theme/my_text_theme.dart';
import '../../../../core/utils/helper_function.dart';
import 'detail_row_widget.dart';

class MovieDetailWidget extends StatelessWidget {
  final MovieDetailModel movie;

  const MovieDetailWidget({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Visibility(
          visible: movie.overview != null || movie.overview!.isNotEmpty,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Overview",
                style: MyTextTheme.myBodySmallTheme(fontSize: 20, fontWeight: FontWeight.bold, textColor: AppTheme.primaryColor),
              ),
              const SizedBox(height: 8),
              Text(movie.overview!, style: MyTextTheme.myBodySmallTheme(fontSize: 16, textColor: Colors.black87).copyWith(height: 1.5)),
              const SizedBox(height: 24),
            ],
          ),
        ),

        Text(
          "Details",
          style: MyTextTheme.myBodySmallTheme(fontSize: 20, fontWeight: FontWeight.bold, textColor: AppTheme.primaryColor),
        ),
        const SizedBox(height: 12),

        DetailRowWidget(label: "Status", value: movie.status ?? "Unknown"),
        DetailRowWidget(label: "Original Language", value: movie.originalLanguage ?? "Unknown"),
        DetailRowWidget(
          label: "Budget",
          value: movie.budget != null && movie.budget! > 0 ? "\$${HelperFunctions.formatCurrency(movie.budget!)}" : "Unknown",
        ),
        DetailRowWidget(
          label: "Revenue",
          value: movie.revenue != null && movie.revenue! > 0 ? "\$${HelperFunctions.formatCurrency(movie.revenue!)}" : "Unknown",
        ),
        DetailRowWidget(label: "Popularity", value: movie.popularity != null ? movie.popularity!.toStringAsFixed(1) : "Unknown"),
      ],
    );
    ;
  }
}
