class MoviesDetailSchema {
  static const String tableName = "movies_detail";

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
  static const String columnPopularity = 'popularity';
  static const String columnReleaseDate = 'release_date';
  static const String columnVideo = 'video';
  static const String columnVoteAverage = 'vote_average';
  static const String columnVoteCount = 'vote_count';
  static const String columnBelongsToCollection = 'belongs_to_collection'; // JSON
  static const String columnBudget = 'budget';
  static const String columnGenres = 'genres'; // JSON array
  static const String columnHomepage = 'homepage';
  static const String columnImdbId = 'imdb_id';
  static const String columnOriginCountry = 'origin_country'; // JSON array
  static const String columnProductionCompanies = 'production_companies'; // JSON array
  static const String columnProductionCountries = 'production_countries'; // JSON array
  static const String columnRevenue = 'revenue';
  static const String columnRuntime = 'runtime';
  static const String columnSpokenLanguages = 'spoken_languages'; // JSON array
  static const String columnStatus = 'status';
  static const String columnTagline = 'tagline';

  // CREATE TABLE query
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
    $columnPopularity REAL,
    $columnReleaseDate TEXT,
    $columnVideo INTEGER,
    $columnVoteAverage REAL,
    $columnVoteCount INTEGER,
    $columnBelongsToCollection TEXT,
    $columnBudget INTEGER,
    $columnGenres TEXT,
    $columnHomepage TEXT,
    $columnImdbId TEXT,
    $columnOriginCountry TEXT,
    $columnProductionCompanies TEXT,
    $columnProductionCountries TEXT,
    $columnRevenue INTEGER,
    $columnRuntime INTEGER,
    $columnSpokenLanguages TEXT,
    $columnStatus TEXT,
    $columnTagline TEXT
  )
  ''';

  ///  Index creation queries
  static const String createIndexOnId = 'CREATE UNIQUE INDEX IF NOT EXISTS idx_${tableName}_id ON $tableName($columnId);';
}
