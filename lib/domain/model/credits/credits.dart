import 'cast.dart';
import 'crew.dart';

class Credits {
  int id;
  List<Cast> cast;
  List<Crew> crew;

  Credits({
    this.id,
    this.cast,
    this.crew,
  });
}
