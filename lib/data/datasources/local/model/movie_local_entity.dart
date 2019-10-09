import 'package:the_movie_db/data/repository/model/movie_entity.dart';

class MovieLocalEntity {
  int id;
  String title;
  String overview;
  String poster;
  double voteAverage;
  String releaseDate;
  String backDrop;

  MovieLocalEntity({this.id, this.title, this.poster, this.overview, this.releaseDate, this.voteAverage, this.backDrop});

  Map<String, dynamic> toMap() {
    return {
      'id' : id,
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
      id : this.id,
      title: this.title,
      image: this.poster,
      overview: this.overview,
      voteAverage: this.voteAverage,
      releaseDate: this.releaseDate,
      backDrop: this.backDrop,
    );
  }
}
