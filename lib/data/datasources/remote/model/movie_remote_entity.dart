import 'package:the_movie_db/data/datasources/local/model/movie_local_entity.dart';
import 'package:the_movie_db/data/repository/model/movie_entity.dart';

import '../utils/constans.dart';

class MovieRemoteEntity {
  int id;
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
      : id = json['id'].toInt(),
        title = json['title'],
        overview = json['overview'],
        poster = json['poster_path'] ?? "",
        voteAverage = json['vote_average'].toDouble(),
        releaseDate = json['release_date'],
        backDrop = json['backdrop_path'];

  MovieEntity toMovieEntity() {
    return MovieEntity(
      id: this.id,
      title: this.title,
      image: Constants.BASE_IMAGE_URL + Constants.IMAGE_SIZE_SMALL + this.poster,
      overview: this.overview,
      voteAverage: this.voteAverage,
      releaseDate: this.releaseDate,
      backDrop: Constants.BASE_IMAGE_URL + Constants.IMAGE_SIZE_MEDIUM + this.backDrop,
    );
  }

  MovieLocalEntity toMovieLocalEntity() {
    return MovieLocalEntity(
      id: this.id,
      title: this.title,
      poster: Constants.BASE_IMAGE_URL + Constants.IMAGE_SIZE_SMALL + this.poster,
      overview: this.overview,
      voteAverage: this.voteAverage,
      releaseDate: this.releaseDate,
      backDrop: Constants.BASE_IMAGE_URL + Constants.IMAGE_SIZE_MEDIUM + this.backDrop,
    );
  }
}
