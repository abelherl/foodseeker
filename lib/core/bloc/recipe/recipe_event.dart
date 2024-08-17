import 'package:equatable/equatable.dart';

abstract class RecipeEvent extends Equatable {
  const RecipeEvent();

  @override
  List<Object?> get props => [];
}

class GetAllRecipeEvent extends RecipeEvent {
  const GetAllRecipeEvent({required this.isOnline});

  final bool isOnline;
}

class SearchRecipeEvent extends RecipeEvent {
  const SearchRecipeEvent({required this.keyword});

  final String keyword;
}

class GetRecipeDetailEvent extends RecipeEvent {
  const GetRecipeDetailEvent({required this.recipeId});

  final String recipeId;
}