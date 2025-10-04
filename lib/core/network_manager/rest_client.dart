import 'package:dio/dio.dart';
import 'package:in_shorts_movies/core/model/movie_detail_model.dart';
import 'package:in_shorts_movies/core/model/movie_list_model.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'rest_client.g.dart';

@RestApi()
abstract class RestClient {
  factory RestClient(Dio dio, {String? baseUrl, ParseErrorLogger? errorLogger}) = _RestClient;

  // Now Playing
  @GET("/movie/now_playing")
  Future<MovieListModel> getNowPlayingMovieList(@Query("language") String language, @Query("page") int page);

  // Trending
  @GET("/trending/movie/day")
  Future<MovieListModel> getTrendingMovieList(@Query("language") String language, @Query("page") int page);

  // Movie Details
  @GET("/movie/{id}")
  Future<MovieDetailModel> getMovieData(@Path("id") int id, @Query("language") String language);
}
