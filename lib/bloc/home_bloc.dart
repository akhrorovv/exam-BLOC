import 'package:bloc/bloc.dart';

import '../models/article_model.dart';
import '../services/http_service.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  List<Article> articles = [];

  HomeBloc() : super(HomeInitialState()) {
    on<LoadArticlesListEvent>(_onLoadArticlesListEvent);
  }

  Future<void> _onLoadArticlesListEvent(LoadArticlesListEvent event, Emitter<HomeState> emit) async{
    var response =
    await Network.GET(Network.API_GET_INFOS, Network.paramsArticle());

    var articleList = Network.parseArticles(response!);
    articles.addAll(articleList);
    emit(HomeArticlesListState(articles));
  }
}