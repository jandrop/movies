import 'package:the_movie_db/data/datasources/local/database_helper.dart';

import 'model/movie_local_entity.dart';

class MoviesLocalDataSourceImp implements MoviesLocalDataSource {

  DatabaseHelper _dbHelper;

  MoviesLocalDataSourceImp(this._dbHelper);

  @override
  saveMovies(List<MovieLocalEntity> movies, MoviesTable table) async {
    _dbHelper.saveMovies(movies, table);
  }

  @override
  Future<List<MovieLocalEntity>> getNextMovies() {
    return _dbHelper.getMovies(MoviesTable.UPCOMING);
  }

  @override
  Future<List<MovieLocalEntity>> getPopularMovies() {
    return _dbHelper.getMovies(MoviesTable.POPULAR);
  }

  @override
  Future<List<MovieLocalEntity>> getTopRatedMovies() {
    return _dbHelper.getMovies(MoviesTable.TOP_RATED);
  }
}

abstract class MoviesLocalDataSource {
  Future<List<MovieLocalEntity>> getPopularMovies();

  Future<List<MovieLocalEntity>> getNextMovies();

  Future<List<MovieLocalEntity>> getTopRatedMovies();

  saveMovies(List<MovieLocalEntity> movies, MoviesTable table);
}
