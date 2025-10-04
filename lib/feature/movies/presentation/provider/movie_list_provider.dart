import 'package:flutter/cupertino.dart';
import 'package:in_shorts_movies/core/model/movie_detail_model.dart';

import '../../../../core/model/movie_list_model.dart';
import '../../domain/usecase/movie_usecase.dart';

class MoviesListProvider extends ChangeNotifier {
  final MovieUseCase movieUseCase;

  MoviesListProvider({required this.movieUseCase});

  List<Result> _trendingMovies = [];
  List<Result> _nowPlayingMovies = [];
  List<Result> _bookMarkedMovies = [];
  MovieDetailModel? _movieDetail;
  bool _isBookMarked = false;

  List<Result> get tendingMovies => _trendingMovies;

  List<Result> get nowPlayingMovies => _nowPlayingMovies;

  List<Result> get bookMarkedMovies => _bookMarkedMovies;

  MovieDetailModel? get movieDetail => _movieDetail;

  bool get isBookMarked => _isBookMarked;

  Future<void> initData() async {
    _trendingMovies = await movieUseCase.getMovieList("trending");
    _nowPlayingMovies = await movieUseCase.getMovieList("now_playing");
    notifyListeners();
  }

  Future<void> getMovieDetail(int id) async {
    // Destructure the record returned by use case
    final data = await movieUseCase.getMovieDetail(id);

    _movieDetail = data.movieDetail;
    _isBookMarked = data.isBookMarked; // store bookmark status if needed

    notifyListeners();
  }

  Future<void> addBookMark(int id) async {
    await movieUseCase.addBookMark(id);
    _isBookMarked = true;
    notifyListeners();
  }

  Future<void> removeBookMark(int id) async {
    await movieUseCase.removeBookMark(id);
    _isBookMarked = false;
    notifyListeners();
  }

  Future<void> getBookMarkedMovies() async {
    _bookMarkedMovies = await movieUseCase.getBookMarkedMovieList();
    notifyListeners();
  }
}
