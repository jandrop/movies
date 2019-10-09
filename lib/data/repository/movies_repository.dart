import 'package:the_movie_db/data/datasources/local/database_helper.dart';
import 'package:the_movie_db/data/datasources/local/model/movie_local_entity.dart';
import 'package:the_movie_db/data/datasources/local/movies_local_datasource.dart';
import 'package:the_movie_db/data/datasources/remote/constans.dart';
import 'package:the_movie_db/data/datasources/remote/model/movie_remote_entity.dart';
import 'package:the_movie_db/data/datasources/remote/movies_remote_datasource.dart';
import 'package:the_movie_db/domain/data_policy.dart';

import 'model/movie_entity.dart';

class MoviesRepositoryImp implements MoviesRepository {
  MoviesLocalDataSource _localDataSource;
  MoviesRemoteDataSource _remoteDataSource;

  MoviesRepositoryImp(this._localDataSource, this._remoteDataSource);

  @override
  Future<List<MovieEntity>> getPopularMovies(DataPolicy dataPolicy) {
    switch (dataPolicy) {
      case DataPolicy.LOCAL:
        return _getPopularMoviesFromLocal();
      case DataPolicy.REMOTE:
        return _getPopularMoviesFromRemote();

      default:
        throw ArgumentError("Invalid argument");
    }
  }

  @override
  Future<List<MovieEntity>> getNextMovies(DataPolicy dataPolicy) async {
    switch (dataPolicy) {
      case DataPolicy.LOCAL:
        return _getNextMoviesFromLocal();
      case DataPolicy.REMOTE:
        return _getNextMoviesFromRemote();
      default:
        throw ArgumentError("Invalid argument");
    }
  }

  @override
  Future<List<MovieEntity>> getTopRatedMovies(DataPolicy dataPolicy) async {
    switch (dataPolicy) {
      case DataPolicy.LOCAL:
        return _getTopMoviesFromLocal();
      case DataPolicy.REMOTE:
        return _getTopMoviesFromRemote();
      default:
        throw ArgumentError("Invalid argument");
    }
  }

  Future<List<MovieEntity>> _getPopularMoviesFromLocal() async {
    var localResponse = await _localDataSource.getPopularMovies();

    if (localResponse.isNotEmpty) {
      return fromLocalEntityToMovieEntity(localResponse);
    } else {
      throw Exception("error: empty local response");
    }
  }

  Future<List<MovieEntity>> _getPopularMoviesFromRemote() async {
    var remoteResponse = await _remoteDataSource.getPopularMovies();
    saveMovies(remoteResponse, MoviesTable.POPULAR);

    if (remoteResponse.isNotEmpty) {
      return fromRemoteEntityToMovieEntity(remoteResponse);
    } else {
      throw Exception("error: empty remote response");
    }
  }

  Future<List<MovieEntity>> _getNextMoviesFromLocal() async {
    var localResponse = await _localDataSource.getPopularMovies();

    if (localResponse.isNotEmpty) {
      return fromLocalEntityToMovieEntity(localResponse);
    } else {
      throw Exception("error: empty local response");
    }
  }

  Future<List<MovieEntity>> _getNextMoviesFromRemote() async {
    var remoteResponse = await _remoteDataSource.getNextMovies();
    saveMovies(remoteResponse, MoviesTable.UPCOMING);

    if (remoteResponse.isNotEmpty) {
      return fromRemoteEntityToMovieEntity(remoteResponse);
    } else {
      throw Exception("error: empty remote response");
    }
  }

  Future<List<MovieEntity>> _getTopMoviesFromLocal() async {
    var localResponse = await _localDataSource.getTopRatedMovies();

    if (localResponse.isNotEmpty) {
      return fromLocalEntityToMovieEntity(localResponse);
    } else {
      throw Exception("error: empty local response");
    }
  }

  Future<List<MovieEntity>> _getTopMoviesFromRemote() async {
    var remoteResponse = await _remoteDataSource.getTopRatedMovies();
    saveMovies(remoteResponse, MoviesTable.TOP_RATED);

    if (remoteResponse.isNotEmpty) {
      return fromRemoteEntityToMovieEntity(remoteResponse);
    } else {
      throw Exception("error: empty remote response");
    }
  }
}

void saveMovies(List<MovieRemoteEntity> movies, MoviesTable table) {
  DatabaseHelper.db.saveMovies(
    movies.map((movie) => movie.toMovieLocalEntity()).toList(),
    table,
  );
}

List<MovieEntity> fromRemoteEntityToMovieEntity(List<MovieRemoteEntity> movieRemoteEntityList) {
  return movieRemoteEntityList.map((movie) => movie.toMovieEntity()).toList();
}

List<MovieEntity> fromLocalEntityToMovieEntity(List<MovieLocalEntity> movieLocalEntityList) {
  return movieLocalEntityList.map((movie) => movie.toMovieEntity()).toList();
}

abstract class MoviesRepository {
  Future<List<MovieEntity>> getPopularMovies(DataPolicy dataPolicy);

  Future<List<MovieEntity>> getNextMovies(DataPolicy dataPolicy);

  Future<List<MovieEntity>> getTopRatedMovies(DataPolicy dataPolicy);
}
