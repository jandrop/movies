import 'package:the_movie_db/data/datasources/local/database_helper.dart';
import 'package:the_movie_db/data/datasources/local/movies_local_datasource.dart';
import 'package:the_movie_db/data/datasources/remote/movies_remote_datasource.dart';
import 'package:the_movie_db/data/repository/movies_repository.dart';
import 'package:the_movie_db/domain/interactor/get_next_movies_interactor.dart';
import 'package:the_movie_db/domain/interactor/get_popular_movies_interactor.dart';
import 'package:the_movie_db/domain/interactor/get_top_rated_movies_interactor.dart';

class Injection {
  static _providesMoviesLocalDataSource() {
    return MoviesLocalDataSourceImp(DatabaseHelper.db);
  }

  static _providesMoviesRemoteDataSource() {
    return MoviesRemoteDataSourceImp();
  }

  static _providesMoviesRepository() {
    return MoviesRepositoryImp(
      _providesMoviesLocalDataSource(),
      _providesMoviesRemoteDataSource(),
    );
  }

  static providesGetPopularMoviesInteractor() {
    return GetPopularMoviesInteractor(
      _providesMoviesRepository(),
    );
  }

  static providesGetNextMoviesInteractor() {
    return GetUpcomingMoviesInteractor(
      _providesMoviesRepository(),
    );
  }

  static providesGetTopRatedMoviesInteractor() {
    return GetTopRatedMoviesInteractor(
      _providesMoviesRepository(),
    );
  }
}
