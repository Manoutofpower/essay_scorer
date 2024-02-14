import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'mainpage.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _usernameController =
      TextEditingController(); // Create a TextEditingController to handle the username input
  final TextEditingController _passwordController =
      TextEditingController(); // Create a TextEditingController to handle the password input
  bool _isLoading =
      false; // Create a boolean variable to track the loading state during registration

  Future<void> _register() async {
    setState(() {
      // Call setState method to notify the Flutter framework to rebuild the UI to update the state
      _isLoading =
          true; // Set the loading state to true, indicating loading during registration
    });

    String username = _usernameController
        .text; // Get the username input from the username controller
    String password = _passwordController
        .text; // Get the password input from the password controller

    try {
      // Make a registration request
      Response response = await Dio().post(

        'waiting for backend',

        // Replace with the URL of the registration backend endpoint
        data: {
          'username': username,
          'password': password,
        },
      );

      // After successful registration, navigate to the main page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>
                MainPage()), // Replace with your main page component
      );
    } catch (error) {
      print(
          'Registration Failed: $error'); // Print the error message if registration fails
    }

    setState(() {
      // Call setState method to notify the Flutter framework to rebuild the UI to update the state
      _isLoading =
          false; // Set the loading state to false, indicating loading has completed during registration
    });
  }

  @override
  Widget build(BuildContext context) {
    // Override the build method to construct the UI
    return Scaffold(
      // Return a Scaffold widget to build the basic structure of the page, such as app bar, drawer menu, bottom navigation bar, etc.
      appBar: AppBar(
        // Set up the app bar for the page
        title: Text('Register'), // Set the title text to "Register"
      ),
      body: Padding(
        // Use Padding widget to add padding to the page content
        padding: EdgeInsets.all(16.0), // Set padding to 16.0
        child: Column(
          // Use Column widget to arrange child widgets vertically
          mainAxisAlignment: MainAxisAlignment.center,
          // Set the mainAxisAlignment to center the child widgets vertically
          children: <Widget>[
            // List containing various child widgets in the page
            TextField(
              // Create a text field for user to input username
              controller: _usernameController,
              // Bind the username controller to the input field
              decoration: InputDecoration(
                // Set the decoration style for the input field
                labelText:
                    'Username', // Set the label text of the input field to "Username"
              ),
            ),
            SizedBox(height: 16.0),
            // Add a SizedBox with height of 16.0
            TextField(
              // Create a text field for user to input password
              controller: _passwordController,
              // Bind the password controller to the input field
              decoration: InputDecoration(
                // Set the decoration style for the input field
                labelText:
                    'Password', // Set the label text of the input field to "Password"
              ),
              obscureText:
                  true, // Set the input text to be obscured for password
            ),
            SizedBox(height: 32.0),
            // Add a SizedBox with height of 32.0
            _isLoading // Conditionally display either a loading indicator or a register button based on loading state
                ? CircularProgressIndicator() // If loading, display a circular progress indicator
                : ElevatedButton(
                    // If not loading, display a raised button
                    onPressed: _register,
                    // Set the button onPressed event to call _register function
                    child: Text(
                        'Register'), // Set the text of the button to "Register"
                  ),
          ],
        ),
      ),
    );
  }
}
