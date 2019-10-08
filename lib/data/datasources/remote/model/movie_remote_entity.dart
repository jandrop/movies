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
}
