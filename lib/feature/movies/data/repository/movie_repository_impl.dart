import 'package:in_shorts_movies/core/model/movie_detail_model.dart';
import 'package:in_shorts_movies/core/model/movie_list_model.dart';
import 'package:in_shorts_movies/data/local/db_helper.dart';
import 'package:in_shorts_movies/data/local/schema/bookmark_schema.dart';
import 'package:in_shorts_movies/data/local/schema/movies_detail_schema.dart';
import 'package:in_shorts_movies/data/local/schema/movies_schema.dart';
import 'package:in_shorts_movies/feature/movies/domain/repository/movie_repository.dart';
import 'package:sqflite/sqflite.dart';

import '../../../../core/model/movie_detail_with_bookmarl.dart';

class MovieRepositoryImpl extends MovieRepository {
  @override
  Future<List<Result>> getMoviesList(String type, String? searchText) async {
    final whereClause = searchText != null && searchText.isNotEmpty
        ? "${MoviesSchema.columnType} = ? AND ${MoviesSchema.columnTitle} LIKE ?"
        : "${MoviesSchema.columnType} = ?";

    final whereArgs = searchText != null && searchText.isNotEmpty ? [type, '%$searchText%'] : [type];

    List<Map<String, dynamic>> data = await DbHelper.instance.queryAllRows(MoviesSchema.tableName, where: whereClause, whereArgs: whereArgs);
    return data.map((element) => Result.fromJson(element, fromDb: true)).toList();
  }

  @override
  Future<MovieDetailWithBookmark> getMovieDetail(int id) async {
    final List<Map<String, dynamic>> data = await DbHelper.instance.queryAllRows(
      MoviesDetailSchema.tableName,
      where: "${MoviesDetailSchema.columnId} = ?",
      whereArgs: [id],
    );
    final List<Map<String, dynamic>> bookMarkedList = await DbHelper.instance.queryAllRows(
      BookmarkSchema.tableName,
      where: "${BookmarkSchema.columnMovieId} = ?",
      whereArgs: [id],
    );
    final isBookMarked = bookMarkedList.isNotEmpty;

    if (data.isEmpty) return MovieDetailWithBookmark(isBookMarked: isBookMarked, movieDetail: null);

    final Map<String, dynamic> firstRow = data.first; // Use .first instead of firstOrNull
    return MovieDetailWithBookmark(isBookMarked: isBookMarked, movieDetail: MovieDetailModel.fromJson(firstRow, fromDb: true));
  }

  @override
  Future<void> addBookMark(int id) async {
    await DbHelper.instance.insert(BookmarkSchema.tableName, {"${BookmarkSchema.columnMovieId}": id}, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  @override
  Future<void> removeBookMark(int id) async {
    await DbHelper.instance.delete(BookmarkSchema.tableName, where: "${BookmarkSchema.columnMovieId} = ?", whereArgs: [id]);
  }

  @override
  Future<List<Result>> getBookMarkMoviesList() async {
    final List<Map<String, dynamic>> data = await DbHelper.instance.rawQuery('''
    SELECT * FROM ${MoviesSchema.tableName}
    INNER JOIN ${BookmarkSchema.tableName} ON ${MoviesSchema.columnId} = ${BookmarkSchema.columnMovieId}
    ''');
    return data.map((element) => Result.fromJson(element, fromDb: true)).toList();
  }
}
