import 'package:the_movie_db/data/datasources/remote/model/credits/credits_remote_entity.dart';
import 'package:the_movie_db/data/datasources/remote/utils/constans.dart';
import 'package:the_movie_db/data/datasources/remote/utils/secrets.dart';

import 'utils/http_handler.dart';

class CreditsRemoteDataSourceImp implements CreditsRemoteDataSource {
  final String credits = "credits";
  final Map<String, String> queryParams = {'api_key': Secrets.API_KEY};

  @override
  Future<CreditsRemoteEntity> getCredits(int movieId) {
    var uri = Uri.https(Constants.BASE_URL, "3/movie/$movieId/$credits", queryParams);
    return _getCreditsFromUri(uri);
  }

  Future<CreditsRemoteEntity> _getCreditsFromUri(Uri uri) {
    return HttpHandler().getJson(uri).then((data) => CreditsRemoteEntity.fromJson(data));
  }
}

abstract class CreditsRemoteDataSource {
  Future<CreditsRemoteEntity> getCredits(int movieId);
}
