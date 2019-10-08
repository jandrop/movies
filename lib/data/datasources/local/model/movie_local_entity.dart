class MovieLocalEntity {
  String title;
  String poster;
  String overview;
  String releaseDate;
  double voteAverage;

  MovieLocalEntity({this.title, this.poster, this.overview, this.releaseDate, this.voteAverage});

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'poster': poster,
      'overview': overview,
      'release_date': releaseDate,
      'vote_average': voteAverage
    };
  }
}
