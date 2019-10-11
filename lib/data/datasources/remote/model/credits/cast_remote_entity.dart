import 'package:the_movie_db/data/datasources/remote/utils/constans.dart';
import 'package:the_movie_db/data/repository/model/credits/cast_entity.dart';

class CastRemoteEntity {
  int castId;
  String character;
  String creditId;
  int gender;
  int id;
  String name;
  int order;
  String profilePath;

  CastRemoteEntity(
      {this.castId, this.character, this.creditId, this.gender, this.id, this.name, this.order, this.profilePath});

  CastRemoteEntity.fromJson(Map<String, dynamic> json) {
    castId = json['cast_id'];
    character = json['character'];
    creditId = json['credit_id'];
    gender = json['gender'];
    id = json['id'];
    name = json['name'];
    order = json['order'];
    profilePath = json['profile_path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cast_id'] = this.castId;
    data['character'] = this.character;
    data['credit_id'] = this.creditId;
    data['gender'] = this.gender;
    data['id'] = this.id;
    data['name'] = this.name;
    data['order'] = this.order;
    data['profile_path'] = this.profilePath;
    return data;
  }

  CastEntity toCastEntity() {
    return CastEntity(
        castId: castId,
        character: character,
        name: name,
        profilePath: profilePath != null
            ? Constants.BASE_IMAGE_URL + Constants.IMAGE_SIZE_SMALL + profilePath
            : Constants.PLACE_HOLDER_IMAGE);
  }
}
