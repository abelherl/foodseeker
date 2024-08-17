import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foodseeker/core/constants/constants.dart';
import 'package:foodseeker/core/errors/failures.dart';
import 'package:foodseeker/core/models/recipe_model.dart';
import 'package:foodseeker/core/repositories/recipe_repository_impl.dart';
import 'package:mockito/mockito.dart';

import '../helpers/test_helper.mocks.dart';

void main() {
  late MockRecipeLocalDatasource localDatasource;
  late MockRecipeRemoteDatasource remoteDatasource;
  late RecipeRepositoryImpl repo;

  setUp(() {
    localDatasource = MockRecipeLocalDatasource();
    remoteDatasource = MockRecipeRemoteDatasource();
    repo = RecipeRepositoryImpl(
      localDatasource: localDatasource,
      remoteDatasource: remoteDatasource,
    );
  });

  final recipes = [RecipeModel.example()];

  group(
    'get all recipe',
    () {
      test(
        'should return a list of RecipeModels if call is successful (Offline)',
        () async {
          when(localDatasource.getAllData()).thenAnswer((_) async => recipes);

          final result = await repo.getAllData(isOnline: false);

          expect(result, equals(Right(recipes)));
        },
      );
      test(
        'should return a Failure if call is unsuccessful (Offline)',
        () async {
          const failure = DatabaseFailure(Constants.errorDatabase);
          when(localDatasource.getAllData()).thenThrow(failure);

          final result = await repo.getAllData(isOnline: false);

          expect(result, equals(const Left(failure)));
        },
      );
      test(
        'should return a list of RecipeModels if call is successful (Online)',
            () async {
          when(remoteDatasource.getAllData()).thenAnswer((_) async => recipes);

          final result = await repo.getAllData(isOnline: true);

          expect(result, equals(Right(recipes)));
        },
      );
      test(
        'should return a Failure if call is unsuccessful (Online)',
            () async {
          const failure = ServerFailure(Constants.errorServer);
          when(remoteDatasource.getAllData()).thenThrow(failure);

          final result = await repo.getAllData(isOnline: true);

          expect(result, equals(const Left(failure)));
        },
      );
    },
  );
}
