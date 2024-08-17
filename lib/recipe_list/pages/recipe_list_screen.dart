import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodseeker/core/bloc/recipe/recipe_bloc.dart';
import 'package:foodseeker/core/bloc/recipe/recipe_event.dart';
import 'package:foodseeker/core/bloc/recipe/recipe_state.dart';
import 'package:foodseeker/core/constants/constants.dart';
import 'package:foodseeker/core/models/recipe_model.dart';
import 'package:foodseeker/core/navigation/navigation.dart';
import 'package:go_router/go_router.dart';

class RecipeListScreen extends StatelessWidget {
  const RecipeListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: RecipeListAppBar(),
      floatingActionButton: FloatingRefreshButton(),
      body: Column(
        children: [
          SearchField(),
          RecipeListView(),
        ],
      ),
    );
  }
}

class FloatingRefreshButton extends StatelessWidget {
  const FloatingRefreshButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.pinkAccent,
      onPressed: () => context.read<RecipeBloc>().add(
        const GetAllRecipeEvent(isOnline: true),
      ),
      child: const Icon(Icons.refresh),
    );
  }
}

class RecipeListAppBar extends StatelessWidget implements PreferredSizeWidget {
  const RecipeListAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('foodseeker.app'),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class RecipeListView extends StatelessWidget {
  const RecipeListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocConsumer<RecipeBloc, RecipeState>(
        listener: (context, state) {},
        builder: (context, state) {
          List<RecipeModel> recipes = [];
          if (state is RecipeLoading) {
            return const LoadingView();
          } else if (state is RecipeError) {
            return ErrorView(message: state.message);
          } else if (state is RecipeSearched) {
            recipes = state.recipes;
          } else if (state is RecipeLoaded) {
            recipes = state.recipes;
          } else if (state is RecipeDetailLoaded) {
            recipes = state.allRecipes;
          }

          if (recipes.isEmpty) return const EmptyView();

          return ListView.builder(
            itemCount: recipes.length,
            itemBuilder: (_, index) => RecipeListItem(recipe: recipes[index]),
          );
        },
      ),
    );
  }
}

class RecipeListItem extends StatelessWidget {
  const RecipeListItem({
    super.key,
    required this.recipe,
  });

  final RecipeModel recipe;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.read<RecipeBloc>().add(
              GetRecipeDetailEvent(recipeId: recipe.id),
            );
        context.push(
          Uri(
            path: Navigation.routeRecipeDetail,
            queryParameters: {'recipeId': recipe.id},
          ).toString(),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        margin: const EdgeInsets.symmetric(horizontal: 16),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 1, color: Colors.pink),
          ),
        ),
        child: Text(
          recipe.name,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}

class EmptyView extends StatelessWidget {
  const EmptyView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text(Constants.emptySearch));
  }
}

class ErrorView extends StatelessWidget {
  const ErrorView({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        message,
        style: const TextStyle(color: Colors.orange),
      ),
    );
  }
}

class LoadingView extends StatelessWidget {
  const LoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}

class SearchField extends StatelessWidget {
  const SearchField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextField(
        decoration: const InputDecoration(
          prefixIcon: Icon(Icons.search),
        ),
        onSubmitted: (keyword) => context.read<RecipeBloc>().add(
          SearchRecipeEvent(keyword: keyword),
        ),
      ),
    );
  }
}
