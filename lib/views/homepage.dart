// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:mp5/views/find_recipe_api.dart'; 
import 'package:mp5/utils/db_helper.dart'; 
import 'package:mp5/views/recipe.dart'; 
import 'package:mp5/views/browse_recipe.dart'; 


class HomePage extends StatelessWidget {
  const HomePage({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome to your Kitchen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const RecipePage()));
              },
              child: const Text('Create Own Recipe'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                // Fetch recipes from database
                final recipes = await DBHelper().getRecipe();

                // Navigate to BrowseRecipe and pass recipes
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BrowseRecipe(recipes: recipes),
                  ),
                );
              },
              child: const Text('Browse Your Recipe'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const FindRecipePage(),
                  ),
                );
              },
              child: const Text('Search Recipe'),
            ),
          ],
        ),
      ),
    );
  }
}
