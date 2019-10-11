import 'package:the_movie_db/domain/interactor/get_credits_interactor.dart';
import 'package:the_movie_db/domain/model/credits/cast.dart';
import 'package:the_movie_db/domain/model/credits/credits.dart';

class DetailPresenterImp implements DetailPresenter {
  GetCreditsInteractor _creditsInteractor;
  DetailView _view;
  Credits _credits;

  DetailPresenterImp(this._view, this._creditsInteractor);

  @override
  initState(int movieId) async {
    _credits = await _creditsInteractor.run(movieId);
    _view.showCast(_credits.cast);
  }
}

abstract class DetailPresenter {
  initState(int movieId);
}

abstract class DetailView {
  showCast(List<Cast> cast);
}
