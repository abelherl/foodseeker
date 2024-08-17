import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foodseeker/core/constants/constants.dart';
import 'package:foodseeker/core/errors/failures.dart';
import 'package:foodseeker/core/models/recipe_model.dart';
import 'package:foodseeker/core/usecases/get_all_recipe.dart';
import 'package:mockito/mockito.dart';

import '../helpers/test_helper.mocks.dart';

void main() {
  late MockRecipeRepository repo;
  late GetAllRecipe usecase;

  setUp(() {
    repo = MockRecipeRepository();
    usecase = GetAllRecipe(repo);
  });

  final recipes = [RecipeModel.example()];

  test(
    'should return a list of RecipeModels from the repository (Offline)',
    () async {
      const isOnline = false;
      when(repo.getAllData(isOnline: isOnline)).thenAnswer(
        (_) async => Right(recipes),
      );

      final result = await usecase.execute(isOnline: isOnline);

      expect(result, Right(recipes));
      verify(repo.getAllData(isOnline: isOnline));
      verifyNoMoreInteractions(repo);
    },
  );
  test(
    'should return a Failure when unsuccessful (Offline)',
        () async {
      const failure = DatabaseFailure(Constants.errorDatabase);
      const isOnline = false;
      when(repo.getAllData(isOnline: isOnline)).thenAnswer(
            (_) async => const Left(failure),
      );

      final result = await usecase.execute(isOnline: isOnline);

      expect(result, const Left(failure));
      verify(repo.getAllData(isOnline: isOnline));
      verifyNoMoreInteractions(repo);
    },
  );
  test(
    'should return a list of RecipeModels from the repository (Online)',
        () async {
      const isOnline = true;
      when(repo.getAllData(isOnline: isOnline)).thenAnswer(
            (_) async => Right(recipes),
      );

      final result = await usecase.execute(isOnline: isOnline);

      expect(result, Right(recipes));
      verify(repo.getAllData(isOnline: isOnline));
      verifyNoMoreInteractions(repo);
    },
  );
  test(
    'should return a Failure when unsuccessful (Online)',
        () async {
      const failure = ServerFailure(Constants.errorServer);
      const isOnline = true;
      when(repo.getAllData(isOnline: isOnline)).thenAnswer(
            (_) async => const Left(failure),
      );

      final result = await usecase.execute(isOnline: isOnline);

      expect(result, const Left(failure));
      verify(repo.getAllData(isOnline: isOnline));
      verifyNoMoreInteractions(repo);
    },
  );
}
