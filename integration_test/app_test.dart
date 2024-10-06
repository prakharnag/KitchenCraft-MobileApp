// ignore_for_file: avoid_print
//This is integration testing where we are testing whether user can browse its own created recipes

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mp5/main.dart' as app;
import 'package:mp5/model/recipe.dart';

void main(){
  group('integration test', () {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  List<Recipe> recipes = [];
  testWidgets("Search Recipe usi API", (tester) async{
    app.main();

    await tester.pumpAndSettle();

    final beginButton = find.widgetWithText(ElevatedButton, 'Click to begin');
    await tester.tap(beginButton);
    await tester.pumpAndSettle();

    await tester.pump(const Duration(seconds: 1));

    final browseButton = find.widgetWithText(ElevatedButton, 'Browse Your Recipe');
    await tester.tap(browseButton);
    await tester.pumpAndSettle();

    await tester.pump(const Duration(seconds: 1));

    for (var recipe in recipes) {
    final titleFinder = find.text(recipe.name);
    final subtitleFinder = find.text(recipe.description);
    
    print('title,$titleFinder');
    print('description,$subtitleFinder');

    expect(titleFinder, findsOneWidget);
    expect(subtitleFinder, findsOneWidget);
  
    await tester.pumpAndSettle();
    await tester.pump(const Duration(seconds: 1));
    }
  });
});
}