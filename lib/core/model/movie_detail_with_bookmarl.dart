import 'package:in_shorts_movies/core/model/movie_detail_model.dart';

class MovieDetailWithBookmark {
  final bool isBookMarked;
  final MovieDetailModel? movieDetail;

  MovieDetailWithBookmark({required this.isBookMarked, this.movieDetail});
}
