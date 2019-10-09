import 'package:flutter_test/flutter_test.dart';
import 'package:the_movie_db/data/datasources/local/database_helper.dart';
import 'package:the_movie_db/data/datasources/local/model/movie_local_entity.dart';
import 'package:the_movie_db/data/datasources/local/movies_local_datasource.dart';

void main() {
  test('when insert one movie in db then the movie can be fetched', () {
    DatabaseHelper.db.init();

    DatabaseHelper helper = DatabaseHelper.db;
    MoviesLocalDataSource localDataSource = MoviesLocalDataSourceImp(helper);

    var sutPopularMovieList = _givenAMovieLocalEntityList("Popular movie");
    var sutUpcomingMovieList = _givenAMovieLocalEntityList("Upcoming movie");
    var sutTopRatedMovieList = _givenAMovieLocalEntityList("Top rated movie");

    localDataSource.saveMovies(sutPopularMovieList, MoviesTable.POPULAR);
    localDataSource.saveMovies(sutUpcomingMovieList, MoviesTable.UPCOMING);
    localDataSource.saveMovies(sutTopRatedMovieList, MoviesTable.TOP_RATED);

    localDataSource.getPopularMovies().then((resp) {
      expect(resp, sutPopularMovieList);
    });

    localDataSource.getNextMovies().then((resp) {
      expect(resp, sutUpcomingMovieList);
    });

    localDataSource.getTopRatedMovies().then((resp) {
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
