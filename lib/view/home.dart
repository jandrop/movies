import 'package:flutter/material.dart';
import 'package:the_movie_db/domain/model/Movie.dart';
import 'package:the_movie_db/injection/Injection.dart';
import 'package:the_movie_db/presenter/HomePresenter.dart';

import 'movie_list_item_widget.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> implements HomeView {
  HomePresenter _presenter;
  List<Movie> _movies = [];
  bool _isLoading = true;
  int _currentIndex = 0;
  String _appBarTitle = "Popular movies";

  _HomeState() {
    _presenter = HomePresenterImp(
      this,
      Injection.providesGetPopularMoviesInteractor(),
      Injection.providesGetNextMoviesInteractor(),
      Injection.providesGetTopRatedMoviesInteractor(),
    );
  }

  @override
  void initState() {
    super.initState();

    _presenter.initState();
  }

  @override
  showMovies(List<Movie> movies) {
    setState(() {
      _movies = movies;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_appBarTitle),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: _getBottomNavigationItems(),
        onTap: (menuPosition) {
          _currentIndex = menuPosition;
          switch (menuPosition) {
            case 0:
              _presenter.onPopularSectionButtonClicked();
              _appBarTitle = "Popular movies";
              break;
            case 1:
              _presenter.onNextSectionButtonClicked();
              _appBarTitle = "Upcoming movies";
              break;
            case 2:
              _presenter.onTopRatedButtonClicked();
              _appBarTitle = "Top rated movies";
              break;
          }
          setState(() {});
        },
      ),
      body: _getMainBody(),
    );
  }

  _getMainBody() {
    var returnWidget;
    if (_isLoading) {
      returnWidget = _getCircularProgress();
    } else {
      returnWidget = _getMovieList(_movies);
    }

    return returnWidget;
  }

  _getCircularProgress() {
    return Center(child: CircularProgressIndicator());
  }

  _getMovieList(List<Movie> movies) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return new MovieListItemWidget(movies[index]);
      },
      itemCount: movies.length,
    );
  }

  List<BottomNavigationBarItem> _getBottomNavigationItems() {
    return [
      BottomNavigationBarItem(icon: Icon(Icons.thumb_up), title: Text("Popular")),
      BottomNavigationBarItem(icon: Icon(Icons.timelapse), title: Text("Next")),
      BottomNavigationBarItem(icon: Icon(Icons.star), title: Text("Top Rated"))
    ];
  }

  @override
  hideLoader() {
    _isLoading = false;
  }

  @override
  showLoader() {
    _isLoading = true;
  }
}
