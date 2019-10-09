import 'package:the_movie_db/data/repository/movies_repository.dart';
import 'package:the_movie_db/domain/model/Movie.dart';

import '../data_policy.dart';

class GetTopRatedMoviesInteractor {
  MoviesRepository _repository;

  GetTopRatedMoviesInteractor(this._repository);

  Future<List<Movie>> run() async {
    var localResponse = await _repository.getTopRatedMovies(DataPolicy.REMOTE);
    if (localResponse.isNotEmpty) {
      return localResponse.map((movie) => movie.toMovie()).toList();
    } else {
      throw Exception("error");
    }
  }
}