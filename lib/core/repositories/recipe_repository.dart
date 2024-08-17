import 'package:dartz/dartz.dart';
import 'package:foodseeker/core/errors/failures.dart';
import 'package:foodseeker/core/models/recipe_model.dart';

abstract class RecipeRepository {
  Future<Either<Failure, List<RecipeModel>>> getAllData({
    required bool isOnline,
  });
}
