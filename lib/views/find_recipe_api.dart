// ignore_for_file: avoid_print
import 'package:url_launcher/url_launcher.dart';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mp5/model/search_recipe.dart';
import 'package:http/http.dart' as http;

class FindRecipePage extends StatefulWidget {
  const FindRecipePage({super.key});

  @override
  State<FindRecipePage> createState() => _FindRecipePageState();
}

class _FindRecipePageState extends State<FindRecipePage> {
  static const String  _apiKey = "a3a0e3981401459a9cddfa1321d70d81"; 
  String _query = '';
  List<SearchRecipe> _recipes = [];
  final List<RecipeInfo> _findRecipes = [];
  
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };

  Future<void> _searchRecipes(String query) async {
   print('Query: $query');
  try{
  
    String url = 'https://api.spoonacular.com/recipes/complexSearch?query=$query&apiKey=$_apiKey';
    print('url: $url');
    final response = await http.get(Uri.parse(url));
    
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final results = data['results'] as List;
      print("response: $results");
      _recipes = results.map((recipe) => SearchRecipe.fromMap(recipe)).toList();
      setState(() {}); // Update UI with new recipes
    } else {
      // Handle error
      print('Failed to load recipes: ${response.statusCode}');
    }

  }
  catch(err){
     throw err.toString();
  }
  }

  Future<void> _getRecipeDetails(int recipeId) async {
    String url = 'https://api.spoonacular.com/recipes/$recipeId/information?apiKey=$_apiKey&includeNutrition=false';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final title = data['title'] as String;
      final image = data['image'] as String;
      final sourceUrl = data['sourceUrl'] as String;
      final summary = data['summary'] as String;

      final recipeInfo = RecipeInfo(
        id: data['id'],
        title: title,
        image: image,
        sourceUrl: sourceUrl,
        summary: summary,
      );

      setState(() {
        _findRecipes.add(recipeInfo); // Add RecipeInfo to the list
      });
    } else {
      // Handle error
      print('Failed to load recipe details: ${response.statusCode}');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Find Recipe'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                labelText: 'Search Food Recipe',
              ),
              onChanged: (value) => setState(() => _query = value),
            ),
          ),
          const SizedBox(width: 10.0),
          ElevatedButton(onPressed: () => _searchRecipes(_query),child: const Text('Find')),
          Expanded(
            child: ListView.builder(
              itemCount: _recipes.length,
              itemBuilder: (context, index) {
                final recipe = _recipes[index];
                return ListTile(
                  title: Text(recipe.title),
                  trailing: IconButton(
                    icon: const Icon(Icons.info),
                    onPressed: () => _getRecipeDetails(recipe.id),
                  ),
                );
              },
            ),
          ),

          // Display recipe details if any
          if (_findRecipes.isNotEmpty)
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columnSpacing: 10.0, // Adjust the spacing between columns
              columns: const [
                DataColumn(label: Text('Title')),
                DataColumn(label: Text('Image')),
                DataColumn(label: Text('Url')),
                DataColumn(label: Text('Summary')),
              ],
              rows: _findRecipes.map((recipeInfo) => _buildRecipeDataRow(recipeInfo)).toList(),
            ),
          )
        ],
      ),
    );
  }

  DataRow _buildRecipeDataRow(RecipeInfo recipeInfo) {
  return DataRow(
    cells: [
      DataCell(Text(recipeInfo.title,
      overflow: TextOverflow.ellipsis, // Handle text overflow with ellipsis
      maxLines: 2, 
      )),
      DataCell(Image.network(recipeInfo.image, width:100, fit: BoxFit.cover,)), 
      DataCell(
        InkWell(
          child: Text(
            recipeInfo.sourceUrl,
            overflow: TextOverflow.ellipsis,
          ),
          onTap: () => _launchURL(recipeInfo.sourceUrl),
        ),
      ),
       DataCell(
      SizedBox(
      height :100,
      child:Text(recipeInfo.summary,
      //overflow: TextOverflow.ellipsis, 
      maxLines: 5,
      )),
    ),
    ],
  );
}
}

_launchURL(String sourceUrl) async {
  if (await canLaunchUrl(Uri.parse(sourceUrl))) {
    await launchUrl(Uri.parse(sourceUrl));
  } else {
    // Handle error (could not launch URL)
    print('Could not launch recipe URL: $sourceUrl');
  }
}