import 'package:the_movie_db/data/datasources/local/database_helper.dart';
import 'package:the_movie_db/data/datasources/local/model/movie_local_entity.dart';
import 'package:the_movie_db/data/datasources/local/movies_local_datasource.dart';
import 'package:the_movie_db/data/datasources/remote/constans.dart';
import 'package:the_movie_db/data/datasources/remote/movies_remote_datasource.dart';

import 'model/movie_entity.dart';

class MoviesRepositoryImp implements MoviesRepository {
  MoviesLocalDataSource _localDataSource;
  MoviesRemoteDataSource _remoteDataSource;

  MoviesRepositoryImp(this._localDataSource, this._remoteDataSource);

  @override
  Future<List<MovieEntity>> getPopularMovies() async {
    var remoteResponse = await _remoteDataSource.getPopularMovies();

    if (remoteResponse.isNotEmpty) {
      await DatabaseHelper.db.saveMovies(
        remoteResponse
            .map((movie) => MovieLocalEntity(
                  title: movie.title,
                  poster: Constants.BASE_IMAGE_URL + movie.poster,
                  overview: movie.overview,
                ))
            .toList(),
        MoviesTable.POPULAR,
      );

      return remoteResponse
          .map((movie) => MovieEntity(
                title: movie.title,
                image: Constants.BASE_IMAGE_URL + movie.poster,
                overview: movie.overview,
              ))
          .toList();
    } else {
      throw Exception("Error");
    }
  }

  @override
  Future<List<MovieEntity>> getNextMovies() async {
    var remoteResponse = await _remoteDataSource.getNextMovies();

    if (remoteResponse.isNotEmpty) {
      return remoteResponse
          .map((movie) => MovieEntity(
                title: movie.title,
                image: Constants.BASE_IMAGE_URL + movie.poster,
                overview: movie.overview,
              ))
          .toList();
    } else {
      throw Exception("Error");
    }
  }

  @override
  Future<List<MovieEntity>> getTopRatedMovies() async {
    var remoteResponse = await _remoteDataSource.getTopRatedMovies();

    if (remoteResponse.isNotEmpty) {
      return remoteResponse
          .map((movie) => MovieEntity(
                title: movie.title,
                image: Constants.BASE_IMAGE_URL + movie.poster,
                overview: movie.overview,
              ))
          .toList();
    } else {
      throw Exception("Error");
    }
  }
}

abstract class MoviesRepository {
  Future<List<MovieEntity>> getPopularMovies();

  Future<List<MovieEntity>> getNextMovies();

  Future<List<MovieEntity>> getTopRatedMovies();
}
