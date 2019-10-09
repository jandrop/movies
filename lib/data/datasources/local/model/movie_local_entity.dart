import 'package:the_movie_db/data/datasources/remote/constans.dart';
import 'package:the_movie_db/data/repository/model/movie_entity.dart';

class MovieLocalEntity {
  String title;
  String overview;
  String poster;
  double voteAverage;
  String releaseDate;
  String backDrop;

  MovieLocalEntity({this.title, this.poster, this.overview, this.releaseDate, this.voteAverage, this.backDrop});

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'poster': poster,
      'overview': overview,
      'release_date': releaseDate,
      'vote_average': voteAverage,
      'backdrop': backDrop
    };
  }

  MovieEntity toMovieEntity() {
    return MovieEntity(
      title: this.title,
      image: Constants.BASE_IMAGE_URL + this.poster,
      overview: this.overview,
      voteAverage: this.voteAverage,
      releaseDate: this.releaseDate,
      backDrop: this.backDrop,
    );
  }
}
