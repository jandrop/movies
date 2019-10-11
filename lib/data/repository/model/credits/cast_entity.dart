import 'package:the_movie_db/domain/model/credits/cast.dart';

class CastEntity {
  int castId;
  String character;
  String name;
  String profilePath;

  CastEntity({
    this.castId,
    this.character,
    this.name,
    this.profilePath,
  });

  Cast toCast() {
    return Cast(
      castId: castId,
      profilePath: profilePath,
      name: name,
      character: character,
    );
  }
}
