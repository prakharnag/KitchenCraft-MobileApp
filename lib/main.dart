//This project allows, user to create new recipe, browse own recipe and drag the recipe to delete it. User can also search for recipes online, this is implemented 
//using REST API calls to spoonacular API

// Widget tests, unit tests and integration tests are also added.

// To run the integration test - execute the "execute_intgration.sh file from terminal- app will run automtically and final result can be seen on terminal"

import 'package:flutter/material.dart';
import 'package:mp5/views/landingpage.dart';

void main() async {
  runApp(const MaterialApp(
      debugShowCheckedModeBanner: false,
      home:  LandingPage(),
      ));
    }
