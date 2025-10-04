class MoviesSchema {
  static const String tableName = 'movies';

  // Columns
  static const String columnId = 'id';
  static const String columnAdult = 'adult';
  static const String columnBackdropPath = 'backdrop_path';
  static const String columnTitle = 'title';
  static const String columnOriginalTitle = 'original_title';
  static const String columnOverview = 'overview';
  static const String columnPosterPath = 'poster_path';
  static const String columnMediaType = 'media_type'; // nullable
  static const String columnOriginalLanguage = 'original_language';
  static const String columnGenreIds = 'genre_ids'; // store as string (comma-separated or JSON)
  static const String columnPopularity = 'popularity';
  static const String columnReleaseDate = 'release_date';
  static const String columnVideo = 'video';
  static const String columnVoteAverage = 'vote_average';
  static const String columnVoteCount = 'vote_count';
  static const String columnType = 'type';

  static String createQuery =
      '''
  CREATE TABLE IF NOT EXISTS $tableName (
    $columnId INTEGER PRIMARY KEY,
    $columnAdult INTEGER,
    $columnBackdropPath TEXT,
    $columnTitle TEXT,
    $columnOriginalTitle TEXT,
    $columnOverview TEXT,
    $columnPosterPath TEXT,
    $columnMediaType TEXT,
    $columnOriginalLanguage TEXT,
    $columnGenreIds TEXT,
    $columnPopularity REAL,
    $columnReleaseDate TEXT,
    $columnVideo INTEGER,
    $columnVoteAverage REAL,
    $columnVoteCount INTEGER,
    $columnType TEXT DEFAULT 'now_playing'
  )
  ''';

  /// Index creation queries
  static const String createIndexOnId = 'CREATE UNIQUE INDEX IF NOT EXISTS idx_${tableName}_id ON $tableName($columnId);';

  static const String createIndexOnTitle = 'CREATE INDEX IF NOT EXISTS idx_${tableName}_title ON $tableName($columnTitle);';

  /// Combine all index queries
  static List<String> get indexQueries => [createIndexOnId, createIndexOnTitle];
}
