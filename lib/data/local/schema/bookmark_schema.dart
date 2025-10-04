class BookmarkSchema {
  static const String tableName = 'bookmarks';

  // Columns
  static const String columnMovieId = 'movie_id';

  ///  Table creation query
  static const String createQuery =
      '''
  CREATE TABLE IF NOT EXISTS $tableName (
    $columnMovieId INTEGER PRIMARY KEY
  )
  ''';

  ///  Index creation (optional since PRIMARY KEY auto-indexes)
  static const String createIndexOnMovieId = 'CREATE UNIQUE INDEX IF NOT EXISTS idx_${tableName}_movie_id ON $tableName($columnMovieId);';

  static List<String> get indexQueries => [createIndexOnMovieId];
}
