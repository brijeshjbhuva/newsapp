import 'dart:convert';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants/constant.dart';
import '../../data/models/api_model.dart';
import '../../data/repositories/article_repo.dart';
import '../../utils/utils.dart';
import 'article_bloc_exporter.dart';

class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {
  ArticleRepository repository;

  ArticleBloc({required this.repository}) : super(ArticleInitialState()) {
    on<FetchArticleEvent>(_mapEventToState);
  }

  ArticleState get initialState => ArticleInitialState();

  _mapEventToState(ArticleEvent event, Emitter<ArticleState> emit) async {
    if (event is FetchArticleEvent) {
      emit(ArticleLoadingState());
      try {
        List<Articles> articles = await repository.getArticles();
        emit(ArticleLoadedState(articles: articles));
      } on SocketException {
        try {
          String? response = PrefsUtils.getString(PrefKeys.articles);
          if (response != null) {
            var data = json.decode(response);
            List<Articles> articles = ApiResultModel.fromJson(data).articles;
            emit(ArticleLoadedState(articles: articles));
          } else {
            emit(ArticleErrorState(message: Strings.error_network));
          }
        } catch (e) {
          emit(ArticleErrorState(message: Strings.error_fetch_data));
        }
      } catch (e) {
        emit(ArticleErrorState(message: e.toString()));
      }
    }
  }
}
