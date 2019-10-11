import 'package:the_movie_db/data/repository/model/credits/cast_entity.dart';
import 'package:the_movie_db/data/repository/model/credits/crew_entity.dart';
import 'package:the_movie_db/domain/model/credits/credits.dart';

class CreditsEntity {
  int id;
  List<CastEntity> cast;
  List<CrewEntity> crew;

  CreditsEntity({
    this.id,
    this.cast,
    this.crew,
  });

  Credits toCredits() {
    return Credits(
      id: id,
      crew: crew.map((data) => data.toCrew()).toList(),
      cast: cast.map((data) => data.toCast()).toList(),
    );
  }
}
