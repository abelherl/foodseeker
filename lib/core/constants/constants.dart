class Constants {
  const Constants._();

  static const getAllRecipeUrl =
      'https://low-carb-recipes.p.rapidapi.com/search?limit=10';
  static const getAllRecipeHeader = {
    'x-rapidapi-key': '791f3367c6msh997e73f43f282dcp118b9fjsn2d5bb65f5130',
    'x-rapidapi-host': 'low-carb-recipes.p.rapidapi.com',
  };

  static const errorServer = 'Failed to get data from the server';
  static const errorDatabase = 'Failed to get data from the database';
  static const errorUnknown = 'Unknown error';
  static const emptySearch = 'No recipe found, try a different keyword';
  static const idNotFound = 'Recipe ID not found';
  static const getAllRecipeDummyPath = 'core/helpers/dummy_data/get_all_recipe_dummy.json';
  static const tableRecipe = 'recipe';
}
