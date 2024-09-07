import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  String fullname = '';
  String email = '';
  String password = '';
  String confirmPassword = '';
  bool isLoading = false;
  List<String> errors = [];

  Future<void> registerUser() async {
    setState(() {
      isLoading = true;
    });
    // Replace with your PHP backend registration endpoint
    final url =
        Uri.parse('http://localhost/flutter_application_1/registration.php');

    // Prepare data to send to the backend
    final response = await http.post(url, body: {
      'fullname': fullname,
      'email': email,
      'password': password,
      'confirm_password': confirmPassword,
    });

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);

      // Check for backend validation errors or success
      if (responseData['success']) {
        // If successful, navigate to index (home) page
        Navigator.pushReplacementNamed(context, '/index');
      } else {
        // Display error messages from the backend
        setState(() {
          errors = List<String>.from(responseData['errors']);
        });
      }
    } else {
      setState(() {
        errors = ['Failed to connect to the server.'];
      });
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Registration Form')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Display error messages
              if (errors.isNotEmpty)
                Column(
                  children: errors
                      .map((error) => Text(error,
                          style: const TextStyle(color: Colors.red)))
                      .toList(),
                ),

              TextFormField(
                decoration: const InputDecoration(labelText: 'Full Name'),
                onChanged: (value) {
                  fullname = value;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Full name is required';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  email = value;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Email is required';
                  } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return 'Enter a valid email';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
                onChanged: (value) {
                  password = value;
                },
                validator: (value) {
                  if (value!.length < 8) {
                    return 'Password must be at least 8 characters';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration:
                    const InputDecoration(labelText: 'Confirm Password'),
                obscureText: true,
                onChanged: (value) {
                  confirmPassword = value;
                },
                validator: (value) {
                  if (value != password) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: isLoading
                    ? null
                    : () {
                        if (_formKey.currentState!.validate()) {
                          registerUser();
                        }
                      },
                child: isLoading
                    ? const CircularProgressIndicator()
                    : const Text('Sign Up'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
