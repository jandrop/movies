import 'package:flutter_test/flutter_test.dart';
import 'package:the_movie_db/data/datasources/local/database_helper.dart';
import 'package:the_movie_db/data/datasources/local/model/movie_local_entity.dart';
import 'package:the_movie_db/data/datasources/local/movies_local_datasource.dart';

void main() {
  test('when insert one movie in db then the movie can be fetched', () {
    MoviesLocalDataSource localDataSource = MoviesLocalDataSourceImp();

    var sutPopularMovieList = _givenAMovieLocalEntityList("Popular movie");
    var sutUpcomingMovieList = _givenAMovieLocalEntityList("Upcoming movie");
    var sutTopRatedMovieList = _givenAMovieLocalEntityList("Top rated movie");

    DatabaseHelper.db.init();

    DatabaseHelper.db.saveMovies(sutPopularMovieList, MoviesTable.POPULAR);
    DatabaseHelper.db.saveMovies(sutUpcomingMovieList, MoviesTable.UPCOMING);
    DatabaseHelper.db.saveMovies(sutTopRatedMovieList, MoviesTable.TOP_RATED);

    DatabaseHelper.db.getMovies(MoviesTable.POPULAR).then((resp) {
      expect(resp, sutPopularMovieList);
    });

    DatabaseHelper.db.getMovies(MoviesTable.POPULAR).then((resp) {
      expect(resp, sutUpcomingMovieList);
    });

    DatabaseHelper.db.getMovies(MoviesTable.POPULAR).then((resp) {
      expect(resp, sutTopRatedMovieList);
    });
  });
}

List<MovieLocalEntity> _givenAMovieLocalEntityList(String title) {
  return [_givenAMovieLocalEntity(title)];
}

MovieLocalEntity _givenAMovieLocalEntity(String title) {
  return MovieLocalEntity(
    title: title,
    poster: "poster",
    overview: "overview",
    releaseDate: "release_date",
    voteAverage: 10.0,
  );
}
