import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:foodseeker/core/constants/constants.dart';
import 'package:foodseeker/core/models/recipe_model.dart';

import '../helpers/json_reader.dart';

void main() {
  test(
    'should be able to parse RecipeModel from json',
    () {
      final json = readJson(Constants.getAllRecipeDummyPath);

      final model = RecipeModel.fromJson(jsonDecode(json).first);

      expect(model, isA<RecipeModel>());
    },
  );
}