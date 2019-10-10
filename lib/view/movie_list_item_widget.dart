import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:the_movie_db/domain/model/Movie.dart';
import 'package:the_movie_db/view/detail/detail.dart';

class MovieListItemWidget extends StatelessWidget {
  final Movie movie;

  MovieListItemWidget(this.movie);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160.0,
      child: Card(
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailScreen(movie: movie),
                  ));
            },
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                MovieImageWidget(movie.image),
                MovieContentWidget(
                  title: movie.title,
                  overview: movie.overview,
                ),
              ],
            ),
          )),
    );
  }
}

class MovieImageWidget extends StatelessWidget {
  final String poster;

  MovieImageWidget(this.poster);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2 / 3,
      child: CachedNetworkImage(
        imageUrl: poster,
        fit: BoxFit.cover,
        placeholder: (context, url) => Center(child: CircularProgressIndicator()),
        errorWidget: (context, url, error) => Center(child: Icon(Icons.error)),
      ),
    );
  }
}

class MovieContentWidget extends StatelessWidget {
  final String title, overview;

  MovieContentWidget({this.title, this.overview});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom: 16.0),
              child: Text(
                title,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.title,
              ),
            ),
            Flexible(
              child: Text(
                overview,
                overflow: TextOverflow.ellipsis,
                maxLines: 5,
                style: Theme.of(context).textTheme.body1,
              ),
            )
          ],
        ),
      ),
    );
  }
}
