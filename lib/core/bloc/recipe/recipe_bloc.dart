import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:collection/collection.dart';
import 'package:foodseeker/core/bloc/recipe/recipe_event.dart';
import 'package:foodseeker/core/bloc/recipe/recipe_state.dart';
import 'package:foodseeker/core/constants/constants.dart';
import 'package:foodseeker/core/usecases/get_all_recipe.dart';
import 'package:rxdart/rxdart.dart';

class RecipeBloc extends Bloc<RecipeEvent, RecipeState> {
  RecipeBloc({required this.getAllRecipe}) : super(RecipeInitial()) {
    on<GetAllRecipeEvent>(_onGetAllRecipe);
    on<SearchRecipeEvent>(
      _onSearchRecipe,
      transformer: debounce(const Duration(milliseconds: 500)),
    );
    on<GetRecipeDetailEvent>(_onGetRecipeDetail);
  }

  final GetAllRecipe getAllRecipe;

  FutureOr<void> _onGetAllRecipe(GetAllRecipeEvent event, emit) async {
    emit(RecipeLoading());

    final result = await getAllRecipe.execute(isOnline: event.isOnline);

    result.fold(
      (l) async {
        // Get offline result only when remote data retrieval failed
        // if (event.isOnline) {
        //   final offlineResult = await getAllRecipe.execute(isOnline: false);
        //   offlineResult.fold(
        //     (_) => emit(RecipeError(l.message)),
        //     (r) => emit(RecipeLoaded(r)),
        //   );
        // } else {
          return emit(RecipeError(l.message));
        // }
      },
      (r) => emit(RecipeLoaded(r)),
    );
  }

  FutureOr<void> _onSearchRecipe(SearchRecipeEvent event, emit) async {
    emit(RecipeLoading());

    // ! Sorry, no idea what's the problem but local database doesn't seem to be working
    final result = await getAllRecipe.execute(isOnline: true);

    result.fold(
          (l) => emit(RecipeError(l.message)),
          (r) {
        if (event.keyword == '') return emit(RecipeLoaded(r));

        final searchedItems = r.where(
              (e) => e.name.toLowerCase().contains(event.keyword.toLowerCase()),
        ).toList();

        emit(RecipeSearched(searchedItems, event.keyword));
      },
    );
  }

  FutureOr<void> _onGetRecipeDetail(GetRecipeDetailEvent event, emit) async {
    emit(RecipeLoading());

    final result = await getAllRecipe.execute(isOnline: true);

    result.fold(
          (l) => emit(RecipeError(l.message)),
          (r) {
        final recipe = r.firstWhereOrNull(
          (e) => e.id.contains(event.recipeId),
        );

        if (recipe == null) {
          return emit(const RecipeError(Constants.idNotFound));
        }

        emit(RecipeDetailLoaded(r, recipe));
      },
    );
  }
}

EventTransformer<T> debounce<T>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}
