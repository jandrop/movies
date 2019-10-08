import 'package:the_movie_db/domain/interactor/get_next_movies_interactor.dart';
import 'package:the_movie_db/domain/interactor/get_popular_movies_interactor.dart';
import 'package:the_movie_db/domain/interactor/get_top_rated_movies_interactor.dart';
import 'package:the_movie_db/domain/model/Movie.dart';

class HomePresenterImp implements HomePresenter {
  GetPopularMoviesInteractor _popularMoviesInteractor;
  GetNextMoviesInteractor _nextMoviesInteractor;
  GetTopRatedMoviesInteractor _topRatedMoviesInteractor;
  HomeView _view;
  List<Movie> _movies = [];

  HomePresenterImp(
    this._view,
    this._popularMoviesInteractor,
    this._nextMoviesInteractor,
    this._topRatedMoviesInteractor,
  );

  @override
  initState() async {
    _view.showLoader();

    _movies = await _popularMoviesInteractor.run();

    _view.hideLoader();
    _view.showMovies(_movies);
  }

  @override
  onNextSectionButtonClicked() async {
    _view.showLoader();

    _movies = await _nextMoviesInteractor.run();

    _view.hideLoader();
    _view.showMovies(_movies);
  }

  @override
  onPopularSectionButtonClicked() async {
    _view.showLoader();

    _movies = await _popularMoviesInteractor.run();

    _view.hideLoader();
    _view.showMovies(_movies);
  }

  @override
  onTopRatedButtonClicked() async {
    _view.showLoader();

    _movies = await _topRatedMoviesInteractor.run();

    _view.hideLoader();
    _view.showMovies(_movies);
  }
}

abstract class HomePresenter {
  initState();

  onPopularSectionButtonClicked();

  onNextSectionButtonClicked();

  onTopRatedButtonClicked();
}

abstract class HomeView {
  showLoader();

  hideLoader();

  showMovies(List<Movie> movies);
}
