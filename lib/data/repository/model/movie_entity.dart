import 'package:the_movie_db/domain/model/Movie.dart';

class MovieEntity {
  int id;
  String title;
  String image;
  String overview;
  double voteAverage;
  String releaseDate;
  String backDrop;

  MovieEntity({this.id, this.title, this.image, this.overview, this.voteAverage, this.releaseDate, this.backDrop});

  Movie toMovie() {
    return Movie(
      id : this.id,
      title: this.title,
      image: this.image,
      overview: this.overview,
      voteAverage: this.voteAverage,
      releaseDate: this.releaseDate,
      backDrop: this.backDrop,
    );
  }
}
