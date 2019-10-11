import 'package:the_movie_db/data/datasources/remote/utils/constans.dart';
import 'package:the_movie_db/data/repository/model/credits/crew_entity.dart';

class CrewRemoteEntity {
  String creditId;
  String department;
  int gender;
  int id;
  String job;
  String name;
  String profilePath;

  CrewRemoteEntity({this.creditId, this.department, this.gender, this.id, this.job, this.name, this.profilePath});

  CrewRemoteEntity.fromJson(Map<String, dynamic> json) {
    creditId = json['credit_id'];
    department = json['department'];
    gender = json['gender'];
    id = json['id'];
    job = json['job'];
    name = json['name'];
    profilePath = json['profile_path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['credit_id'] = this.creditId;
    data['department'] = this.department;
    data['gender'] = this.gender;
    data['id'] = this.id;
    data['job'] = this.job;
    data['name'] = this.name;
    data['profile_path'] = this.profilePath;
    return data;
  }

  CrewEntity toCrewEntity() {
    return CrewEntity(
        creditId: creditId,
        name: name,
        job: job,
        department: department,
        profilePath: profilePath != null
            ? Constants.BASE_IMAGE_URL + Constants.IMAGE_SIZE_MEDIUM + profilePath
            : Constants.PLACE_HOLDER_IMAGE);
  }
}
