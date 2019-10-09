import 'package:the_movie_db/data/repository/movies_repository.dart';
import 'package:the_movie_db/domain/model/Movie.dart';

import '../data_policy.dart';

class GetTopRatedMoviesInteractor {
  MoviesRepository _repository;

  GetTopRatedMoviesInteractor(this._repository);

  Future<List<Movie>> run() async {
    var response = await _repository.getTopRatedMovies(DataPolicy.REMOTE);
    if (response.isNotEmpty) {
      return response
          .map((movie) => Movie(
                title: movie.title,
                image: movie.image,
                overview: movie.overview,
                backDrop: movie.backDrop,
              ))
          .toList();
    } else {
      throw Exception("error");
    }
  }
}
