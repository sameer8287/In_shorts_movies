import 'package:in_shorts_movies/core/model/movie_detail_model.dart';
import 'package:in_shorts_movies/core/model/movie_detail_with_bookmarl.dart';
import 'package:in_shorts_movies/core/model/movie_list_model.dart';

abstract class MovieRepository {
  Future<List<Result>> getMoviesList(String type,String? searchText);

  Future<List<Result>> getBookMarkMoviesList();

  Future<MovieDetailWithBookmark> getMovieDetail(int id);

  Future<void> addBookMark(int id);

  Future<void> removeBookMark(int id);

}
