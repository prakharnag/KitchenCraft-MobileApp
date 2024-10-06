// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:mp5/utils/db_helper.dart'; 

class RecipePage extends StatefulWidget {
  const RecipePage({super.key});

  @override
  RecipePageState createState() => RecipePageState();
}

class RecipePageState extends State<RecipePage> {
  final _formKey = GlobalKey<FormState>(); // For form validation
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _createRecipe() async {
    if (_formKey.currentState!.validate()) {
      String name = _nameController.text;
      String description = _descriptionController.text;

      int result = await DBHelper().insertRecipe(name, description);

      if (result > 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Recipe created successfully!'))
        );
        _nameController.text = '';
        _descriptionController.text = '';
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to create recipe!'))
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Recipe'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context), 
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Recipe Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a recipe name.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
                maxLines: null,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _createRecipe,
                child: const Text('Done'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
