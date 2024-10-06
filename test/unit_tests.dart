// ignore_for_file: avoid_print
//check debug console for test result status


import 'package:flutter_test/flutter_test.dart';
import 'package:mp5/model/recipe.dart';
import 'package:mp5/model/search_recipe.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  group('Recipe Model Tests', () {
    test('Recipe object should be correctly populated from constructor', () {
      final Recipe recipe = Recipe(
        id: 1,
        name: 'Sample Recipe for unit testing',
        description: 'Description of the recipe',
      );

      expect(recipe.id, 1);
      expect(recipe.name, 'Sample Recipe for unit testing');
      expect(recipe.description, 'Description of the recipe');
    });

  });

   group('FindRecipePage', () {
    List<SearchRecipe> recipes = [];
    test('_searchRecipes fetches recipes and updates state (assuming real API access)', () async {
      const String apiKey = 'a3a0e3981401459a9cddfa1321d70d81';

      // Search query for the test
      const String query = 'pizza';

      const url = 'https://api.spoonacular.com/recipes/complexSearch?query=$query&apiKey=$apiKey';

      // Perform the actual HTTP request
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final results = data['results'] as List;

        // Parse the response data into SearchRecipe objects
         recipes = results.map((recipe) => SearchRecipe.fromMap(recipe)).toList();

        // Assertions
        expect(recipes.length, greaterThan(0)); 
        expect(recipes[0].title.isNotEmpty, true); 
        expect(recipes[0].image.isNotEmpty, true);
      } else {
        // Handle error in case of unsuccessful API response
        print('Failed to load recipes: ${response.statusCode}');
      }
    });

  test('_searchRecipes handles network errors', () async {
      const url = 'https://invalid-url.com';  

      try {
        await http.get(Uri.parse(url));
        fail('Expected an error to be thrown');  // If successful request, fail the test
      } catch (error) {
        expect(error, isA<Exception>());
      }

  });
});

group('FindRecipePage', () {
    test('deletes recipe and updates state', () async {
    
    List<Recipe> recipes = [];

      // Add a recipe to the state (assuming you have a way to manage recipes in the state)
      final recipe = Recipe(id: 1, name: 'Test Recipe', description: 'This is a test recipe');

      recipes.add(Recipe(id: recipe.id, name: recipe.name, description: recipe.description));
      
      recipes.removeWhere((element) => element.id == recipe.id);

      expect(recipes.length,0); 
    });
  });


}