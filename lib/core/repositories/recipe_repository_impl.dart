import 'package:dartz/dartz.dart';
import 'package:foodseeker/core/datasources/recipe_local_datasource.dart';
import 'package:foodseeker/core/datasources/recipe_remote_datasource.dart';
import 'package:foodseeker/core/errors/failures.dart';
import 'package:foodseeker/core/models/recipe_model.dart';
import 'package:foodseeker/core/repositories/recipe_repository.dart';

class RecipeRepositoryImpl extends RecipeRepository {
  RecipeRepositoryImpl({
    required this.localDatasource,
    required this.remoteDatasource,
  });

  final RecipeLocalDatasource localDatasource;
  final RecipeRemoteDatasource remoteDatasource;

  @override
  Future<Either<Failure, List<RecipeModel>>> getAllData({
    required bool isOnline,
  }) async {
    try {
      final result = isOnline
          ? await remoteDatasource.getAllData()
          : await localDatasource.getAllData();

      return Right(result);
    } on Failure catch (e) {
      return Left(e);
    }
  }
}
