import 'package:in_shorts_movies/data/local/schema/bookmark_schema.dart';
import 'package:in_shorts_movies/data/local/schema/movies_detail_schema.dart';
import 'package:in_shorts_movies/data/local/schema/movies_schema.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;
import '../../core/utils/helper_function.dart';

class DbHelper {
  DbHelper._privateConstructor();

  static final instance = DbHelper._privateConstructor();

  factory DbHelper() {
    return instance;
  }

  final String dbName = "in_short_movies.db";
  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    try {
      String dbPath = await getDatabasesPath();
      dbPath = path.join(dbPath, dbName);
      return await openDatabase(
        dbPath,
        version: 1,
        onCreate: (db, version) async {
          await _onCreate(db, version);
        },
        onUpgrade: _onUpgrade,
      );
    } catch (e) {
      HelperFunctions.printLog('Error initializing database', e);
      rethrow;
    }
  }

  Future<void> _onCreate(Database db, int version) async {
    // Create Movies table
    await db.execute(MoviesSchema.createQuery);
    // Create indexes for Movies table
    for (final query in MoviesSchema.indexQueries) {
      await db.execute(query);
    }
    // Create Movies details table
    await db.execute(MoviesDetailSchema.createQuery);
    // Create indexes for Movies detail table
    await db.execute(MoviesDetailSchema.createIndexOnId);
    // Create for BookmarkSchema  table
    await db.execute(BookmarkSchema.createQuery);
    // Create indexes for BookmarkSchema table
    await db.execute(BookmarkSchema.createIndexOnMovieId);
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {}

  // Insert a row into a table
  Future<int> insert(String table, Map<String, dynamic> row, {ConflictAlgorithm? conflictAlgorithm}) async {
    final db = await database;
    return await db.insert(table, row, conflictAlgorithm: conflictAlgorithm);
  }

  // Insert multiple row into a table
  Future<void> insertAll(String table, Iterable<Map<String, dynamic>> rows) async {
    final db = await database;
    return await db.transaction((db) async {
      for (final row in rows) {
        await db.insert(table, row);
      }
    });
  }

  // Retrieve all rows from a table
  Future<List<Map<String, dynamic>>> queryAllRows(
    String table, {
    List<String>? columns,
    String? where,
    List<Object?>? whereArgs,
    int? offset,
    int? limit,
  }) async {
    final db = await database;
    return await db.query(table, columns: columns, where: where, whereArgs: whereArgs, offset: offset, limit: limit);
  }

  // Retrieve all rows from a table
  Future<List<Map<String, dynamic>>> rawQuery(String query) async {
    final db = await database;
    return await db.rawQuery(query);
  }

  // Update a row in a table
  Future<int> update(String table, Map<String, dynamic> row, String where, List<dynamic> whereArgs) async {
    final db = await database;
    return await db.update(table, row, where: where, whereArgs: whereArgs);
  }

  // Delete a row from a table
  Future<int> delete(String table, {required String where, List<dynamic>? whereArgs}) async {
    final db = await database;
    return await db.delete(table, where: where, whereArgs: whereArgs);
  }
}
