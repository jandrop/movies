import 'package:the_movie_db/data/datasources/local/model/movie_local_entity.dart';
import 'package:the_movie_db/data/repository/model/movie_entity.dart';
import '../constans.dart';

class MovieRemoteEntity {
  String title;
  String overview;
  String poster;
  double voteAverage;
  String releaseDate;
  String backDrop;

  factory MovieRemoteEntity(Map json) {
    return MovieRemoteEntity.deserialize(json);
  }

  MovieRemoteEntity.deserialize(Map json)
      : title = json['title'],
        overview = json['overview'],
        poster = json['poster_path'] ?? "",
        voteAverage = json['vote_average'].toDouble(),
        releaseDate = json['release_date'],
        backDrop = json['backdrop_path'];

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

  MovieLocalEntity toMovieLocalEntity() {
    return MovieLocalEntity(
      title: this.title,
      poster: Constants.BASE_IMAGE_URL + this.poster,
      overview: this.overview,
      voteAverage: this.voteAverage,
      releaseDate: this.releaseDate,
      backDrop: this.backDrop,
    );
  }
}
