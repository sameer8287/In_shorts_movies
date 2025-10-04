import 'package:in_shorts_movies/core/model/movie_detail_model.dart';
import 'package:in_shorts_movies/core/model/movie_detail_with_bookmarl.dart';
import 'package:in_shorts_movies/core/model/movie_list_model.dart';
import 'package:in_shorts_movies/core/utils/helper_function.dart';

import '../repository/movie_repository.dart';

class MovieUseCase {
  final MovieRepository movieRepository;

  MovieUseCase({required this.movieRepository});

  Future<List<Result>> getMovieList(String type) async {
    return await movieRepository.getMoviesList(type);
  }

  Future<List<Result>> getBookMarkedMovieList() async {
    return await movieRepository.getBookMarkMoviesList();
  }

  Future<MovieDetailWithBookmark> getMovieDetail(int id) async {
    HelperFunctions.printLog("Movie Id", id);
    return await movieRepository.getMovieDetail(id);
  }

  Future<void> addBookMark(int id) async {
    return await movieRepository.addBookMark(id);
  }

  Future<void> removeBookMark(int id) async {
    return await movieRepository.removeBookMark(id);
  }
}
