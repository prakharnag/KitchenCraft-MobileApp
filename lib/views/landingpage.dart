import 'package:flutter/material.dart';
import 'package:mp5/views/homepage.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('KitchenCraft')
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                 Navigator.push(context,
                 MaterialPageRoute(builder: (context) => const HomePage()),
        );
              },
              child: const Text('Click to begin'),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
