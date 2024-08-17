import 'package:flutter_test/flutter_test.dart';
import 'package:foodseeker/core/datasources/recipe_local_datasource.dart';
import 'package:foodseeker/core/models/recipe_model.dart';
import 'package:mockito/mockito.dart';
import '../helpers/test_helper.mocks.dart';

void main() {
  late MockBox<RecipeModel> mockBox;
  late RecipeLocalDatasourceImpl datasource;

  setUp(() {
    mockBox = MockBox();
    datasource = RecipeLocalDatasourceImpl(box: mockBox);
  });

  final recipes = [RecipeModel.example(), RecipeModel.example2()];

  group(
    'GetAllData',
    () {
      test(
        'should return a valid RecipeModel when data is available',
        () async {
          when(mockBox.values).thenReturn(recipes);

          final result = await datasource.getAllData();

          expect(result, isA<List<RecipeModel>>());
        },
      );
    },
  );
}
