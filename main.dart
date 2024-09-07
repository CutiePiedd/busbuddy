import 'package:flutter/material.dart';
import 'registration_page.dart'; // Import the registration page

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Registration Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // Set RegistrationPage as the initial route
      home: RegistrationPage(),
      routes: {
        '/index': (context) => HomePage(), // Define other routes like index
      },
    );
  }
}

// Placeholder HomePage (Index page)
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home Page")),
      body: const Center(child: Text("Welcome to the App")),
    );
  }
}
