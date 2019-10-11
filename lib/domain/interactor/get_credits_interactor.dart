import 'package:the_movie_db/data/repository/credits_repository.dart';
import 'package:the_movie_db/domain/model/credits/credits.dart';

import '../data_policy.dart';

class GetCreditsInteractor {
  CreditsRepository _repository;

  GetCreditsInteractor(this._repository);

  Future<Credits> run(int movieId) async {
    var localResponse = await _repository.getCredits(movieId, DataPolicy.REMOTE);
    if (localResponse != null) {
      return localResponse.toCredits();
    } else {
      throw Exception("error");
    }
  }
}
