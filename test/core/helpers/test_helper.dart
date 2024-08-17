import 'package:foodseeker/core/datasources/recipe_local_datasource.dart';
import 'package:foodseeker/core/datasources/recipe_remote_datasource.dart';
import 'package:foodseeker/core/repositories/recipe_repository.dart';
import 'package:foodseeker/core/usecases/get_all_recipe.dart';
import 'package:mockito/annotations.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

@GenerateMocks(
  [
    RecipeLocalDatasource,
    RecipeRemoteDatasource,
    RecipeRepository,
    GetAllRecipe,
    HiveInterface,
    Box,
  ],
  customMocks: [MockSpec<http.Client>(as: #MockHttpClient)],
)
void main() {

}