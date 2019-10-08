import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'model/movie_local_entity.dart';

class MoviesLocalDataSourceImp implements MoviesLocalDataSource {
  @override
  Future<List<MovieLocalEntity>> getMovies() async {
    return null;
  }

  @override
  saveMovies(List<MovieLocalEntity> movies) async {}
}

abstract class MoviesLocalDataSource {
  Future<List<MovieLocalEntity>> getMovies();

  saveMovies(List<MovieLocalEntity> movies);
}
