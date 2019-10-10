import 'package:the_movie_db/data/datasources/remote/secrets.dart';
import 'package:the_movie_db/data/datasources/remote/constans.dart';
import 'utils/http_handler.dart';
import 'model/movie_remote_entity.dart';

class MoviesRemoteDataSourceImp implements MoviesRemoteDataSource {
  final String popularMovies = "3/movie/popular";
  final String upcomingMovies = "3/movie/upcoming";
  final String topRatedMovies = "3/movie/top_rated";
  final Map<String, String> queryParams = {
    'api_key': Secrets.API_KEY,
    'page': "1",
    'language': Constants.LANGUAGE,
  };

  @override
  Future<List<MovieRemoteEntity>> getPopularMovies() {
    var uri = Uri.https(Constants.BASE_URL, popularMovies, queryParams);
    return _getMovieFromUri(uri);
  }

  @override
  Future<List<MovieRemoteEntity>> getUpcomingMovies() {
    var uri = Uri.https(Constants.BASE_URL, upcomingMovies, queryParams);
    return _getMovieFromUri(uri);
  }

  @override
  Future<List<MovieRemoteEntity>> getTopRatedMovies() {
    var uri = Uri.https(Constants.BASE_URL, topRatedMovies, queryParams);
    return _getMovieFromUri(uri);
  }

  Future<List<MovieRemoteEntity>> _getMovieFromUri(Uri uri) {
    return HttpHandler()
        .getJson(uri)
        .then(((data) => data['results'].map<MovieRemoteEntity>((item) => MovieRemoteEntity(item)).toList()));
  }
}

abstract class MoviesRemoteDataSource {
  Future<List<MovieRemoteEntity>> getPopularMovies();

  Future<List<MovieRemoteEntity>> getUpcomingMovies();

  Future<List<MovieRemoteEntity>> getTopRatedMovies();
}
