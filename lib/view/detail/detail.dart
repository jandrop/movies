import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:the_movie_db/domain/model/Movie.dart';
import 'package:the_movie_db/domain/model/credits/cast.dart';
import 'package:the_movie_db/injection/Injection.dart';
import 'package:the_movie_db/presenter/DetailPresenter.dart';
import 'package:the_movie_db/view/detail/widgets/border_circle_avatar.dart';

class DetailScreen extends StatefulWidget {
  final Movie _movie;

  DetailScreen(this._movie);

  @override
  State createState() {
    return _DetailScreenState(_movie);
  }
}

class _DetailScreenState extends State<DetailScreen> implements DetailView {
  static const String routeName = '/detail';
  List<Cast> _cast = [];
  final Movie _movie;
  DetailPresenter _presenter;

  _DetailScreenState(this._movie) {
    _presenter = DetailPresenterImp(
      this,
      Injection.providesGetCreditsInteractor(),
    );
  }

  @override
  void initState() {
    super.initState();
    _presenter.initState(_movie.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_movie.title)),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          CachedNetworkImage(
            imageUrl: _movie.image,
            fit: BoxFit.cover,
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
            child: Container(
              color: Colors.black.withOpacity(0.5),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                CachedNetworkImage(
                  imageUrl: _movie.backDrop,
                  fit: BoxFit.cover,
                ),
                getTitleAndRate(context, _movie),
                Container(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    _movie.overview,
                    style: Theme.of(context).textTheme.body1.copyWith(color: Colors.white, fontFamily: "Ubuntu-Light"),
                  ),
                ),
                _getCastList(_cast),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  showCast(List<Cast> cast) {
    setState(() {
      _cast = cast;
    });
  }
}

Widget getTitleAndRate(BuildContext context, Movie movie) {
  return Container(
    margin: EdgeInsets.all(16.0),
    child: Row(
      children: <Widget>[
        Expanded(
          child: Text(
            movie.title,
            overflow: TextOverflow.fade,
            maxLines: 1,
            style: TextStyle(
              fontFamily: 'Ubuntu',
              color: Colors.white,
              fontStyle: FontStyle.normal,
              fontSize: 24.0,
            ),
          ),
        ),
        Text(
          movie.voteAverage.toString(),
          style: Theme.of(context).textTheme.body1.copyWith(color: Colors.white, fontFamily: 'Ubuntu'),
        ),
        SizedBox(width: 4.0),
        Icon(
          Icons.star,
          color: Colors.white,
          size: 16.0,
        )
      ],
    ),
  );
}

_getCastList(List<Cast> cast) {
  return Column(
    children: <Widget>[
      SizedBox.fromSize(
        size: const Size.fromHeight(180.0),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.all(16.0),
          itemBuilder: (context, index) {
            return BorderCircleAvatar(cast[index]);
          },
          itemCount: cast.length,
        ),
      ),
    ],
  );
}
