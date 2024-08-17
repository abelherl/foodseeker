import 'dart:convert';

import 'package:foodseeker/core/constants/constants.dart';
import 'package:foodseeker/core/errors/failures.dart';
import 'package:foodseeker/core/models/recipe_model.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart';

abstract class RecipeRemoteDatasource {
  Future<List<RecipeModel>> getAllData();
}

class RecipeRemoteDatasourceImpl extends RecipeRemoteDatasource {
  RecipeRemoteDatasourceImpl({required this.client, required this.box});

  final Client client;
  final Box<RecipeModel> box;

  @override
  Future<List<RecipeModel>> getAllData() async {
    try {
      final response = await client.get(
        Uri.parse(Constants.getAllRecipeUrl),
        headers: Constants.getAllRecipeHeader,
      );

      if (response.statusCode == 200) {
        List<RecipeModel> models = [];

        box.clear();
        for (final data in jsonDecode(response.body)) {
          final recipe = RecipeModel.fromJson(data);
          models.add(recipe);
          box.add(recipe);
        }

        return models;
      } else {
        throw const ServerFailure(Constants.errorServer);
      }
    } on ServerFailure catch (_) {
      rethrow;
    } catch (_) {
      throw const UnknownFailure(Constants.errorUnknown);
    }
  }
}
