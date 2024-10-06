import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mp5/views/homepage.dart';

void main() {
  group('HomePageTest', () {
    testWidgets('renders all buttons correctly', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: HomePage()));

      // Find buttons by text
      final createButton = find.text('Create Own Recipe');
      final browseButton = find.text('Browse Your Recipe');
      final findRecipeButton = find.text('Search Recipe');

      // Verify buttons exist
      expect(createButton, findsOneWidget);
      expect(browseButton, findsOneWidget);
      expect(findRecipeButton, findsOneWidget);
    });

    testWidgets('Create Own Recipe button navigates to new view and renders label text with two text fields', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: HomePage()));

      final createButton = find.text('Create Own Recipe');
      await tester.tap(createButton);
      await tester.pumpAndSettle();

  
      final recipeNameField = find.widgetWithText(TextFormField, 'Recipe Name'); // Replace with actual label text
      final descriptionField = find.widgetWithText(TextFormField, 'Description'); // Replace with actual label text 
      expect(recipeNameField, findsOneWidget);
      expect(descriptionField, findsOneWidget);
      });

    testWidgets('Browse Your Recipe button navigates to new view', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: HomePage()));

       final browseButton = find.text('Browse Your Recipe'); // Update with actual button text
       await tester.tap(browseButton);
      await tester.pumpAndSettle();
    
    });

     testWidgets('Search Recipe button navigates to new view', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: HomePage()));

      final searchButton = find.text('Search Recipe');
      await tester.tap(searchButton);
      await tester.pumpAndSettle();

      expect(find.text('Find Recipe'), findsOneWidget);
    });
  });
}
