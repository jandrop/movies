import 'package:the_movie_db/data/repository/movies_repository.dart';
import 'package:the_movie_db/domain/model/Movie.dart';

class GetPopularMoviesInteractor {
  MoviesRepository _repository;

  GetPopularMoviesInteractor(this._repository);

  Future<List<Movie>> run() async {
    var response = await _repository.getPopularMovies();
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
