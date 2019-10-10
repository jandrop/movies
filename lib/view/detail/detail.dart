import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart' as prefix0;
import 'package:flutter/material.dart';
import 'package:the_movie_db/domain/model/Movie.dart';

class DetailScreen extends StatelessWidget {
  static const String routeName = '/detail';
  final Movie movie;

  DetailScreen({@required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(movie.title)),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Image.network(
            movie.image,
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
                Image(
                  image: NetworkImage(movie.backDrop),
                  fit: BoxFit.cover,
                ),
                Container(
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
                        style: Theme.of(context).textTheme.body2.copyWith(
                              color: Colors.white,
                              fontFamily: 'Ubuntu',
                            ),
                      ),
                      SizedBox(width: 4.0),
                      Icon(
                        Icons.star,
                        color: Colors.white,
                        size: 16.0,
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    movie.overview,
                    style: Theme.of(context).textTheme.body1.copyWith(
                          color: Colors.white,
                          fontFamily: "Ubuntu",
                        ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
