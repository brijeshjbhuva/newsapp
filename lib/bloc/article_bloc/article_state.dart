import 'package:equatable/equatable.dart';

import '../../data/models/api_model.dart';

abstract class ArticleState extends Equatable {}

class ArticleInitialState extends ArticleState {
  @override
  List<Object> get props => throw UnimplementedError();
}

class ArticleLoadingState extends ArticleState {
  @override
  List<Object> get props => throw UnimplementedError();
}

class ArticleLoadedState extends ArticleState {
 final List<Articles> articles;

  ArticleLoadedState({required this.articles});

  @override
  List<Object> get props => throw UnimplementedError();
}

class ArticleErrorState extends ArticleState {
 final String message;

  ArticleErrorState({required this.message});

  @override
  List<Object> get props => throw UnimplementedError();
}
