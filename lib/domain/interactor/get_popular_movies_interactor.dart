import 'package:the_movie_db/data/repository/movies_repository.dart';
import 'package:the_movie_db/domain/model/Movie.dart';

import '../data_policy.dart';

class GetPopularMoviesInteractor {
  MoviesRepository _repository;

  GetPopularMoviesInteractor(this._repository);

  Future<List<Movie>> run() async {
    var response = await _repository.getPopularMovies(DataPolicy.REMOTE);
    if (response.isNotEmpty) {
      return response
          .map((movie) => movie.toMovie()).toList();
    } else {
      throw Exception("error");
    }
  }
}
