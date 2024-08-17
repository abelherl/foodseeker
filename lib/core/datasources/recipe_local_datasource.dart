import 'package:foodseeker/core/constants/constants.dart';
import 'package:foodseeker/core/errors/failures.dart';
import 'package:foodseeker/core/models/recipe_model.dart';
import 'package:hive/hive.dart';

abstract class RecipeLocalDatasource {
  Future<List<RecipeModel>> getAllData();
}

class RecipeLocalDatasourceImpl extends RecipeLocalDatasource {
  RecipeLocalDatasourceImpl({required this.box});

  final Box<RecipeModel> box;

  @override
  Future<List<RecipeModel>> getAllData() async {
    try {
      return box.values.toList();
    } catch (_) {
      throw const DatabaseFailure(Constants.errorDatabase);
    }
  }
}