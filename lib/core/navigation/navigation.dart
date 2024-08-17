import 'package:foodseeker/recipe_detail/pages/recipe_detail_screen.dart';
import 'package:foodseeker/recipe_list/pages/recipe_list_screen.dart';
import 'package:go_router/go_router.dart';

class Navigation {
  const Navigation._();

  static const routeRecipeList = '/';
  static const routeRecipeDetail = '/detail/:recipeId';

  static final router = GoRouter(
    initialLocation: routeRecipeList,
    routes: [
      GoRoute(
        path: routeRecipeList,
        builder: (context, state) => const RecipeListScreen(),
      ),
      GoRoute(
        path: routeRecipeDetail,
        builder: (context, state) => RecipeDetailScreen(
          recipeId: state.pathParameters['recipeId']!,
        ),
      ),
    ],
  );
}
