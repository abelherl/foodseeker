import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foodseeker/core/bloc/recipe/recipe_bloc.dart';
import 'package:foodseeker/core/bloc/recipe/recipe_event.dart';
import 'package:foodseeker/core/bloc/recipe/recipe_state.dart';
import 'package:foodseeker/core/constants/constants.dart';
import 'package:foodseeker/core/errors/failures.dart';
import 'package:foodseeker/core/models/recipe_model.dart';
import 'package:mockito/mockito.dart';

import '../helpers/test_helper.mocks.dart';

void main() {
  late MockGetAllRecipe getAllRecipeUsecase;
  late RecipeBloc bloc;

  setUp(() {
    getAllRecipeUsecase = MockGetAllRecipe();
    bloc = RecipeBloc(getAllRecipe: getAllRecipeUsecase);
  });

  final recipes = [RecipeModel.example(), RecipeModel.example2()];

  test('initial state should be RecipeInitial', () {
    expect(bloc.state, RecipeInitial());
  });

  group(
    'GetAllRecipeEvent',
    () {
      blocTest<RecipeBloc, RecipeState>(
        'should emit [RecipeLoading, RecipeLoaded] when successful (Offline)',
        build: () {
          when(getAllRecipeUsecase.execute(isOnline: false)).thenAnswer(
            (_) async => Right(recipes),
          );
          return bloc;
        },
        act: (bloc) => bloc.add(const GetAllRecipeEvent(isOnline: false)),
        wait: const Duration(milliseconds: 500),
        expect: () => [RecipeLoading(), RecipeLoaded(recipes)],
      );
      blocTest<RecipeBloc, RecipeState>(
        'should emit [RecipeLoading, RecipeError] when unsuccessful (Offline)',
        build: () {
          when(getAllRecipeUsecase.execute(isOnline: false)).thenAnswer(
            (_) async => const Left(DatabaseFailure(Constants.errorDatabase)),
          );
          return bloc;
        },
        act: (bloc) => bloc.add(const GetAllRecipeEvent(isOnline: false)),
        wait: const Duration(milliseconds: 500),
        expect: () => [
          RecipeLoading(),
          const RecipeError(Constants.errorDatabase),
        ],
      );
      blocTest<RecipeBloc, RecipeState>(
        'should emit [RecipeLoading, RecipeLoaded] when successful (Online)',
        build: () {
          when(getAllRecipeUsecase.execute(isOnline: true)).thenAnswer(
            (_) async => Right(recipes),
          );
          return bloc;
        },
        act: (bloc) => bloc.add(const GetAllRecipeEvent(isOnline: true)),
        wait: const Duration(milliseconds: 500),
        expect: () => [RecipeLoading(), RecipeLoaded(recipes)],
      );
    },
  );

  group(
    'SearchRecipeEvent',
    () {
      blocTest<RecipeBloc, RecipeState>(
        'should emit [RecipeLoading, RecipeSearched] when successful',
        build: () {
          when(getAllRecipeUsecase.execute(isOnline: true)).thenAnswer(
            (_) async => Right(recipes),
          );
          return bloc;
        },
        act: (bloc) => bloc.add(const SearchRecipeEvent(keyword: 'Keto')),
        wait: const Duration(milliseconds: 500),
        expect: () => [
          RecipeLoading(),
          RecipeSearched([recipes.first], 'Keto'),
        ],
      );
      blocTest<RecipeBloc, RecipeState>(
        'should emit [RecipeLoading, RecipeError] when unsuccessful',
        build: () {
          when(getAllRecipeUsecase.execute(isOnline: true)).thenAnswer(
            (_) async => const Left(DatabaseFailure(Constants.errorDatabase)),
          );
          return bloc;
        },
        act: (bloc) => bloc.add(const SearchRecipeEvent(keyword: 'Keto')),
        wait: const Duration(milliseconds: 500),
        expect: () => [
          RecipeLoading(),
          const RecipeError(Constants.errorDatabase),
        ],
      );
      blocTest<RecipeBloc, RecipeState>(
        'should emit [RecipeLoading, RecipeLoaded] when keyword is empty',
        build: () {
          when(getAllRecipeUsecase.execute(isOnline: true)).thenAnswer(
            (_) async => Right(recipes),
          );
          return bloc;
        },
        act: (bloc) => bloc.add(const SearchRecipeEvent(keyword: '')),
        wait: const Duration(milliseconds: 500),
        expect: () => [RecipeLoading(), RecipeLoaded(recipes)],
      );
    },
  );

  group(
    'GetRecipeDetailEvent',
    () {
      blocTest<RecipeBloc, RecipeState>(
        'should emit [RecipeLoading, RecipeDetailLoaded] when successful',
        build: () {
          when(getAllRecipeUsecase.execute(isOnline: true)).thenAnswer(
            (_) async => Right(recipes),
          );
          return bloc;
        },
        act: (bloc) => bloc.add(
          GetRecipeDetailEvent(recipeId: recipes.first.id),
        ),
        wait: const Duration(milliseconds: 500),
        expect: () => [RecipeLoading(), RecipeDetailLoaded(recipes, recipes.first),],
      );
      blocTest<RecipeBloc, RecipeState>(
        'should emit [RecipeLoading, RecipeError] when unsuccessful',
        build: () {
          when(getAllRecipeUsecase.execute(isOnline: true)).thenAnswer(
            (_) async => const Left(DatabaseFailure(Constants.errorDatabase)),
          );
          return bloc;
        },
        act: (bloc) => bloc.add(
          GetRecipeDetailEvent(recipeId: recipes.first.id),
        ),
        wait: const Duration(milliseconds: 500),
        expect: () => [
          RecipeLoading(),
          const RecipeError(Constants.errorDatabase),
        ],
      );
      blocTest<RecipeBloc, RecipeState>(
        'should emit [RecipeLoading, RecipeError] when recipe ID not found',
        build: () {
          when(getAllRecipeUsecase.execute(isOnline: true)).thenAnswer(
            (_) async => Right(recipes),
          );
          return bloc;
        },
        act: (bloc) => bloc.add(const GetRecipeDetailEvent(recipeId: 'random')),
        wait: const Duration(milliseconds: 500),
        expect: () => [
          RecipeLoading(),
          const RecipeError(Constants.idNotFound),
        ],
      );
    },
  );
}
