import 'package:the_movie_db/data/repository/model/credits/credits_entity.dart';

import 'cast_remote_entity.dart';
import 'crew_remote_entity.dart';

class CreditsRemoteEntity {
  int id;
  List<CastRemoteEntity> cast;
  List<CrewRemoteEntity> crew;

  CreditsRemoteEntity({this.id, this.cast, this.crew});

  CreditsRemoteEntity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['cast'] != null) {
      cast = new List<CastRemoteEntity>();
      json['cast'].forEach((v) {
        cast.add(new CastRemoteEntity.fromJson(v));
      });
    }
    if (json['crew'] != null) {
      crew = new List<CrewRemoteEntity>();
      json['crew'].forEach((v) {
        crew.add(new CrewRemoteEntity.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.cast != null) {
      data['cast'] = this.cast.map((v) => v.toJson()).toList();
    }
    if (this.crew != null) {
      data['crew'] = this.crew.map((v) => v.toJson()).toList();
    }
    return data;
  }

  CreditsEntity toCreditsEntity() {
    return CreditsEntity(
      id: id,
      cast: cast.map((data) => data.toCastEntity()).toList(),
      crew: crew.map((data) => data.toCrewEntity()).toList(),
    );
  }
}
