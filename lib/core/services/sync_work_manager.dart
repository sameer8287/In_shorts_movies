import 'package:in_shorts_movies/core/model/movie_list_model.dart';
import 'package:in_shorts_movies/core/network_manager/dio_container.dart';
import 'package:in_shorts_movies/core/utils/logger_utils.dart';
import 'package:in_shorts_movies/data/local/db_helper.dart';
import 'package:in_shorts_movies/data/local/schema/movies_detail_schema.dart';
import 'package:in_shorts_movies/data/local/schema/movies_schema.dart';
import 'package:sqflite/sqflite.dart';

import '../model/movie_detail_model.dart';

class SyncWorkManager {
  // Singleton pattern
  SyncWorkManager._privateConstructor();

  static final SyncWorkManager instance = SyncWorkManager._privateConstructor();

  factory SyncWorkManager() {
    return instance;
  }

  // Method to initialize the sync work manager
  Future<void> syncAllData() async {
    // Initialization logic here

    await syncNowPlayingMovies();
    await syncTrendingMovies();
  }

  Future<void> syncNowPlayingMovies() async {
    String language = "en-US"; // Can be dynamic based on user preference
    int page = 1;
    int limit = 2; // Limit to first 5 pages for sync
    bool hasMorePages = true;

    // Sync logic for now playing movies
    while (hasMorePages) {
      try {
        MovieListModel data = await restClient.getNowPlayingMovieList(language, page);

        // Process and store data locally
        // For example: saveMoviesToLocalDatabase(data.results);
        final result = data.results ?? [];

        if (page < limit && result.isNotEmpty) {
          for (Result i in result) {
            AppLogger.i("Now Playing Movie: ${i.title}");
            await DbHelper.instance.insert(MoviesSchema.tableName, i.toJson(toDb: true), conflictAlgorithm: ConflictAlgorithm.replace);
            await syncMovieDetails(i.id ?? 0);
          }
          page++;
        } else {
          hasMorePages = false;
        }
      } catch (e, stackTrace) {
        hasMorePages = false;
        // Handle error (log or show a message)
        AppLogger.e("Error syncing NowPlaying movies: $e");
        AppLogger.e("Error syncing NowPlaying movies stacktrace: ${stackTrace.toString()}");
      }
    }
  }

  Future<void> syncTrendingMovies() async {
    String language = "en-US"; // Can be dynamic based on user preference
    int page = 1;
    int limit = 2; // Limit to first 5 pages for sync
    bool hasMorePages = true;

    // Sync logic for now playing movies
    while (hasMorePages) {
      try {
        MovieListModel data = await restClient.getTrendingMovieList(language, page);

        // Process and store data locally
        // For example: saveMoviesToLocalDatabase(data.results);
        final result = data.results ?? [];

        if (page < limit && result.isNotEmpty) {
          for (Result i in result) {
            AppLogger.i("Now Playing Movie: ${i.title}");
            final data = i.toJson(toDb: true);
            data[MoviesSchema.columnType] = "trending";
            await DbHelper.instance.insert(MoviesSchema.tableName, data, conflictAlgorithm: ConflictAlgorithm.replace);
            await syncMovieDetails(i.id ?? 0);
          }
          page++;
        } else {
          hasMorePages = false;
        }
      } catch (e, stackTrace) {
        hasMorePages = false;
        // Handle error (log or show a message)
        AppLogger.e("Error syncing trending movies: $e");
        AppLogger.e("Error syncing trending movies stacktrace: ${stackTrace.toString()}");
      }
    }
  }

  Future<void> syncMovieDetails(int movieId) async {
    String language = "en-US";
    try {
      // Fetch movie details from API
      MovieDetailModel detail = await restClient.getMovieData(movieId, language);
      AppLogger.i("Synced details for movie ID: ${detail.id}");
      await DbHelper.instance.insert(MoviesDetailSchema.tableName, detail.toJson(toDb: true), conflictAlgorithm: ConflictAlgorithm.replace);
    } catch (e) {
      // Handle error (log or show a message)
      AppLogger.e("Error syncing movie details for ID $movieId: $e");
    }
  }
}
