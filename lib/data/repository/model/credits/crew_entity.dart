import 'package:the_movie_db/domain/model/credits/crew.dart';

class CrewEntity {
  String creditId;
  String department;
  int gender;
  int id;
  String job;
  String name;
  String profilePath;

  CrewEntity({
    this.creditId,
    this.department,
    this.job,
    this.name,
    this.profilePath,
  });

  Crew toCrew() {
    return Crew(
      creditId: creditId,
      name: name,
      profilePath: profilePath,
      job: job,
      department: department,
    );
  }
}
