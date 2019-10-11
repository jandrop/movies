import 'package:flutter/material.dart';
import 'package:the_movie_db/domain/model/credits/cast.dart';

class BorderCircleAvatar extends StatelessWidget {
  final Cast _cast;

  const BorderCircleAvatar(this._cast);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16.0),
      child: Column(
        children: <Widget>[
          Container(
            child: new CircleAvatar(
              backgroundImage: NetworkImage(
                _cast.profilePath,
              ),
            ),
            width: 64.0,
            height: 64.0,
            padding: EdgeInsets.all(2.0),
            decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white),
          ),
          Padding(
            padding: EdgeInsets.only(top: 8.0),
            child: Text(
              _cast.name,
              style: Theme.of(context).textTheme.caption.copyWith(color: Colors.white, fontFamily: 'Ubuntu-Condensed'),
            ),
          )
        ],
      ),
    );
  }
}
