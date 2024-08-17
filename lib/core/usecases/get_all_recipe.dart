import 'package:dartz/dartz.dart';
import 'package:foodseeker/core/errors/failures.dart';
import 'package:foodseeker/core/models/recipe_model.dart';
import 'package:foodseeker/core/repositories/recipe_repository.dart';

class GetAllRecipe {
  GetAllRecipe(this.repository);

  final RecipeRepository repository;

  Future<Either<Failure, List<RecipeModel>>> execute({required bool isOnline}) async {
    return await repository.getAllData(isOnline: isOnline);
  }
}