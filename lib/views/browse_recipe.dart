import 'package:flutter/material.dart';
import 'package:mp5/model/recipe.dart'; 
import 'package:mp5/utils/db_helper.dart';

class BrowseRecipe extends StatefulWidget {
  final List<Recipe> recipes;

  const BrowseRecipe({super.key, required this.recipes});

  @override
  State<BrowseRecipe> createState() => _BrowseRecipeState();
}

class _BrowseRecipeState extends State<BrowseRecipe> {
  List<Recipe> recipes = [];

  @override
  void initState() {
    super.initState();
    recipes = widget.recipes; 
  }

  void _deleteRecipe(int recipeId) async {
    await DBHelper().deleteRecipe(recipeId);
    setState(() {
      recipes.removeWhere((recipe) => recipe.id == recipeId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Browse Recipes'),
      ),
      body: ListView.builder(
        itemCount: recipes.length,
        itemBuilder: (context, index) {
          final recipe = recipes[index];
          return Dismissible(
            key: Key(recipe.id.toString()), // Unique key for dismissal
            onDismissed: (direction) async {
               _deleteRecipe(recipe.id);
               ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Recipe "${recipe.name}" deleted'),
              ),
               );
            },
            child: ListTile(
              title: Text(recipe.name), 
              subtitle: Text(recipe.description),
            ),
          );
        },
      ),
    );
  }
}
