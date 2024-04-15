import 'package:flutter/material.dart';
import 'Pages/initialpage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.blueGrey, // Set the primary theme color.
        scaffoldBackgroundColor: Colors.grey[850], // Background color for Scaffold widgets.
        appBarTheme: AppBarTheme(
          color: Colors.blueGrey, // Background color for AppBars.
          iconTheme: IconThemeData(color: Colors.white), // Icon color for AppBars.
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            primary: Colors.cyanAccent, // Text and icon color for text buttons.
            backgroundColor: Colors.blueGrey[700], // Background color for text buttons.
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)), // Rounded shape for buttons.
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10), // Padding inside the button.
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white, // Text color for elevated buttons.
            backgroundColor: Colors.deepPurple[300]!, // Background color for elevated buttons.
          ),
        ),
        cardTheme: CardTheme(
          color: Colors.grey[800], // Background color for cards.
          shadowColor: Colors.blueGrey.shade600, // Shadow color for cards.
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.cyanAccent), // Border color for enabled input fields.
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.cyanAccent.shade700), // Border color for unfocused input fields.
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.cyanAccent), // Border color for focused input fields.
          ),
          labelStyle: TextStyle(color: Colors.cyanAccent), // Text color for input field labels.
        ),
      ),
      home: const InitialPage(), // The widget that will be shown when the app launches.
      debugShowCheckedModeBanner: false, // Remove the debug banner in the upper right corner.
    );
  }
}
