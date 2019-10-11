import 'package:the_movie_db/data/datasources/remote/credits_remote_datasource.dart';
import 'package:the_movie_db/data/datasources/remote/model/credits/credits_remote_entity.dart';
import 'package:the_movie_db/data/repository/model/credits/credits_entity.dart';
import 'package:the_movie_db/domain/data_policy.dart';

class CreditsRepositoryImp implements CreditsRepository {
  CreditsRemoteDataSource _remoteDataSource;

  CreditsRepositoryImp(this._remoteDataSource);

  @override
  Future<CreditsEntity> getCredits(int movieId, DataPolicy dataPolicy) {
    switch (dataPolicy) {
      case DataPolicy.LOCAL:
        return null;
        //return _getCreditsFromLocal();
        break;
      case DataPolicy.REMOTE:
        return _getCreditsFromRemote(movieId);
        break;
      default:
        throw ArgumentError("Invalid argument");
        break;
    }
  }

  Future<CreditsEntity> _getCreditsFromRemote(int movieId) async {
    var remoteResponse = await _remoteDataSource.getCredits(movieId);

    if (remoteResponse != null) {
      return fromRemoteEntityToMovieEntity(remoteResponse);
    } else {
      throw Exception("error: empty remote response");
    }
  }
}

CreditsEntity fromRemoteEntityToMovieEntity(CreditsRemoteEntity creditsRemoteEntity) {
  return creditsRemoteEntity.toCreditsEntity();
}

abstract class CreditsRepository {
  Future<CreditsEntity> getCredits(int movieId, DataPolicy dataPolicy);
}
