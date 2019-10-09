import 'package:the_movie_db/data/datasources/local/database_helper.dart';
import 'package:the_movie_db/data/datasources/local/model/movie_local_entity.dart';
import 'package:the_movie_db/data/datasources/local/movies_local_datasource.dart';
import 'package:the_movie_db/data/datasources/remote/constans.dart';
import 'package:the_movie_db/data/datasources/remote/model/movie_remote_entity.dart';
import 'package:the_movie_db/data/datasources/remote/movies_remote_datasource.dart';

import 'model/movie_entity.dart';

class MoviesRepositoryImp implements MoviesRepository {
  MoviesLocalDataSource _localDataSource;
  MoviesRemoteDataSource _remoteDataSource;

  MoviesRepositoryImp(this._localDataSource, this._remoteDataSource);

  @override
  Future<List<MovieEntity>> getPopularMovies() async {
    var remoteResponse = await _remoteDataSource.getPopularMovies();
    var localResponse =  await _localDataSource.getPopularMovies();

    if (remoteResponse.isNotEmpty) {
      return toMovieEntity(remoteResponse);
    } else {
      throw Exception("Error");
    }
  }

  @override
  Future<List<MovieEntity>> getNextMovies() async {
    var remoteResponse = await _remoteDataSource.getNextMovies();
    var localResponse =  await _localDataSource.getNextMovies();

    if (remoteResponse.isNotEmpty) {
      return toMovieEntity(remoteResponse);
    } else {
      throw Exception("Error");
    }
  }

  @override
  Future<List<MovieEntity>> getTopRatedMovies() async {
    var remoteResponse = await _remoteDataSource.getTopRatedMovies();
    var localResponse =  await _localDataSource.getTopRatedMovies();

    if (remoteResponse.isNotEmpty) {
      return toMovieEntity(remoteResponse);
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

List<MovieEntity> toMovieEntity(List<MovieRemoteEntity> movieRemoteEntityList) {
  return movieRemoteEntityList
      .map((movie) => MovieEntity(
            title: movie.title,
            image: Constants.BASE_IMAGE_URL + movie.poster,
            overview: movie.overview,
          ))
      .toList();
}

abstract class MoviesRepository {
  Future<List<MovieEntity>> getPopularMovies();

  Future<List<MovieEntity>> getNextMovies();

  Future<List<MovieEntity>> getTopRatedMovies();
}
