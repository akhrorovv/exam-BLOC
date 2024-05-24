import 'package:equatable/equatable.dart';
import 'package:exam/models/article_model.dart';
import 'package:flutter/foundation.dart';

@immutable
abstract class HomeState extends Equatable {}

class HomeInitialState extends HomeState {
  @override
  List<Object?> get props => [];
}

class HomeArticlesListState extends HomeState {
  final List<Article> articles;

  HomeArticlesListState(this.articles);

  @override
  List<Object> get props => [articles];
}