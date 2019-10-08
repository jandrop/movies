import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';
import 'model/movie_local_entity.dart';

class DatabaseHelper {
  String path;

  DatabaseHelper._();

  static final DatabaseHelper db = DatabaseHelper._();

  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await init();
    return _database;
  }

  init() async {
    String path = await getDatabasesPath();
    path = join(path, 'movies.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreateTables,
    );
  }

  _onCreateTables(Database db, int version) async {
    await db.execute(
        """CREATE TABLE popular_movies (id INTEGER PRIMARY KEY, title TEXT, poster TEXT, overview TEXT, release_date TEXT, vote_average REAL)""");
    await db.execute(
        """CREATE TABLE upcoming_movies (id INTEGER PRIMARY KEY, title TEXT, poster TEXT, overview TEXT, release_date TEXT, vote_average REAL)""");
    await db.execute(
        """CREATE TABLE top_rated_movies (id INTEGER PRIMARY KEY, title TEXT, poster TEXT, overview TEXT, release_date TEXT, vote_average REAL)""");
  }

  saveMovies(List<MovieLocalEntity> movies, MoviesTable table) async {
    final db = await database;
    for (var m in movies) {
      await db.insert(
        _getTableName(table),
        m.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  Future<List<MovieLocalEntity>> getMovies(MoviesTable table) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(_getTableName(table));

    return List.generate(maps.length, (i) {
      return MovieLocalEntity(
        title: maps[i]['title'],
        poster: maps[i]['poster'],
        overview: maps[i]['overview'],
        releaseDate: maps[i]['release_date'],
        voteAverage: maps[i]['vote_average'],
      );
    });
  }
}

enum MoviesTable { POPULAR, UPCOMING, TOP_RATED }

_getTableName(MoviesTable table) {
  switch (table) {
    case MoviesTable.POPULAR:
      return "popular_movies";
      break;
    case MoviesTable.UPCOMING:
      return "upcomin_movies";
      break;
    case MoviesTable.TOP_RATED:
      return "top_rated_movies";
      break;
  }
}
