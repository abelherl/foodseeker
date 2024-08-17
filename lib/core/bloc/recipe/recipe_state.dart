import 'package:equatable/equatable.dart';
import 'package:foodseeker/core/models/recipe_model.dart';

abstract class RecipeState extends Equatable {
  const RecipeState();

  @override
  List<Object?> get props => [];
}

class RecipeInitial extends RecipeState {}

class RecipeLoading extends RecipeState {}

class RecipeLoaded extends RecipeState {
  final List<RecipeModel> recipes;

  const RecipeLoaded(this.recipes);

  @override
  List<Object?> get props => [recipes];
}

class RecipeDetailLoaded extends RecipeState {
  final List<RecipeModel> allRecipes;
  final RecipeModel recipe;

  const RecipeDetailLoaded(this.allRecipes, this.recipe);

  @override
  List<Object?> get props => [recipe];
}

class RecipeSearched extends RecipeState {
  final List<RecipeModel> recipes;
  final String keyword;

  const RecipeSearched(this.recipes, this.keyword);

  @override
  List<Object?> get props => [recipes, keyword];
}

class RecipeError extends RecipeState {
  final String message;

  const RecipeError(this.message);

  @override
  List<Object?> get props => [message];
}