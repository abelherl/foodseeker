import 'package:flutter_test/flutter_test.dart';
import 'package:foodseeker/core/constants/constants.dart';
import 'package:foodseeker/core/datasources/recipe_remote_datasource.dart';
import 'package:foodseeker/core/errors/failures.dart';
import 'package:foodseeker/core/models/recipe_model.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

import '../helpers/json_reader.dart';
import '../helpers/test_helper.mocks.dart';

void main() {
  late MockHttpClient mockHttpClient;
  late MockBox<RecipeModel> mockBox;
  late RecipeRemoteDatasourceImpl datasource;

  setUp(() {
    mockHttpClient = MockHttpClient();
    mockBox = MockBox();
    datasource = RecipeRemoteDatasourceImpl(
      client: mockHttpClient,
      box: mockBox,
    );
  });

  group(
    'GetAllData',
    () {
      test(
        'should return a valid RecipeModel when the response code is 200',
        () async {
          final json = readJson(Constants.getAllRecipeDummyPath);
          when(
            mockHttpClient.get(
              Uri.parse(Constants.getAllRecipeUrl),
              headers: Constants.getAllRecipeHeader,
            ),
          ).thenAnswer((_) async => http.Response(json, 200));
          when(mockBox.clear()).thenAnswer((_) async => 1);
          when(mockBox.add(any)).thenAnswer((_) async => 1);

          final result = await datasource.getAllData();

          expect(result, isA<List<RecipeModel>>());
          verify(
            mockHttpClient.get(
              Uri.parse(Constants.getAllRecipeUrl),
              headers: Constants.getAllRecipeHeader,
            ),
          );
        },
      );

      test(
        'should throw a ServerFailure when the response code is 404 or other',
        () async {
          when(
            mockHttpClient.get(
              Uri.parse(Constants.getAllRecipeUrl),
              headers: Constants.getAllRecipeHeader,
            ),
          ).thenAnswer((_) async => http.Response('Not found', 404));

          final matcher = throwsA(isA<ServerFailure>());
          expect(() async => await datasource.getAllData(), matcher);
        },
      );
    },
  );
}
