import 'package:foodseeker/core/bloc/recipe/recipe_bloc.dart';
import 'package:foodseeker/core/constants/constants.dart';
import 'package:foodseeker/core/datasources/recipe_local_datasource.dart';
import 'package:foodseeker/core/datasources/recipe_remote_datasource.dart';
import 'package:foodseeker/core/models/recipe_model.dart';
import 'package:foodseeker/core/repositories/recipe_repository.dart';
import 'package:foodseeker/core/repositories/recipe_repository_impl.dart';
import 'package:foodseeker/core/usecases/get_all_recipe.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

final sl = GetIt.instance;

Future<void> setUpInjection() async {
  // external
  sl.registerLazySingleton(() => http.Client());

  Hive
    ..init((await getApplicationDocumentsDirectory()).path)
    ..registerAdapter(RecipeModelAdapter());
  final box = await Hive.openBox<RecipeModel>(Constants.tableRecipe);

  // datasource
  sl.registerLazySingleton<RecipeLocalDatasource>(
    () => RecipeLocalDatasourceImpl(box: box),
  );
  sl.registerLazySingleton<RecipeRemoteDatasource>(
    () => RecipeRemoteDatasourceImpl(client: sl(), box: box),
  );

  // repository
  sl.registerLazySingleton<RecipeRepository>(
    () => RecipeRepositoryImpl(
      localDatasource: sl(),
      remoteDatasource: sl(),
    ),
  );

  // usecase
  sl.registerLazySingleton(() => GetAllRecipe(sl()));

  // bloc
  sl.registerFactory(() => RecipeBloc(getAllRecipe: sl()));
}
