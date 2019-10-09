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
        throw ArgumentError("Something went wrong");
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

    if (remoteResponse.isNotEmpty) {
      return fromRemoteEntityToMovieEntity(remoteResponse);
    } else {
      throw Exception("error: empty remote response");
    }
  }

  @override
  Future<List<MovieEntity>> getNextMovies(DataPolicy dataPolicy) async {
    var remoteResponse = await _remoteDataSource.getNextMovies();
    var localResponse = await _localDataSource.getNextMovies();

    if (remoteResponse.isNotEmpty) {
      return fromRemoteEntityToMovieEntity(remoteResponse);
    } else {
      throw Exception("Error");
    }
  }

  @override
  Future<List<MovieEntity>> getTopRatedMovies(DataPolicy dataPolicy) async {
    var remoteResponse = await _remoteDataSource.getTopRatedMovies();
    var localResponse = await _localDataSource.getTopRatedMovies();

    if (remoteResponse.isNotEmpty) {
      return fromRemoteEntityToMovieEntity(remoteResponse);
    } else {
      throw Exception("Error");
    }
  }
}

void saveMovies(List<MovieRemoteEntity> movies, MoviesTable table) {
  DatabaseHelper.db.saveMovies(
    movies
        .map((movie) => MovieLocalEntity(
              title: movie.title,
              poster: Constants.BASE_IMAGE_URL + movie.poster,
              overview: movie.overview,
            ))
        .toList(),
    table,
  );
}

List<MovieEntity> fromRemoteEntityToMovieEntity(List<MovieRemoteEntity> movieRemoteEntityList) {
  return movieRemoteEntityList
      .map((movie) => MovieEntity(
            title: movie.title,
            image: Constants.BASE_IMAGE_URL + movie.poster,
            overview: movie.overview,
          ))
      .toList();
}

List<MovieEntity> fromLocalEntityToMovieEntity(List<MovieLocalEntity> movieLocalEntityList) {
  return movieLocalEntityList
      .map((movie) => MovieEntity(
            title: movie.title,
            image: Constants.BASE_IMAGE_URL + movie.poster,
            overview: movie.overview,
          ))
      .toList();
}

abstract class MoviesRepository {
  Future<List<MovieEntity>> getPopularMovies(DataPolicy dataPolicy);

  Future<List<MovieEntity>> getNextMovies(DataPolicy dataPolicy);

  Future<List<MovieEntity>> getTopRatedMovies(DataPolicy dataPolicy);
}
