import 'package:flutter/material.dart';
import 'loginpage.dart';
import 'registerpage.dart';

class InitialPage extends StatefulWidget {
  const InitialPage({Key? key}) : super(key: key);

  @override
  State<InitialPage> createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[850],
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 20),
              Text(
                'Essay Scorer',
                style: TextStyle(
                  color: Colors.grey[300],
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Unlock your writing potential',
                style: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 50),
              Card(
                color: Colors.grey[800],
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      _buildButton(context, 'Log In', LoginPage(), Colors.deepPurple[300]!),
                      SizedBox(height: 20),
                      _buildButton(context, 'Register', RegisterPage(), Colors.teal[300]!),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButton(BuildContext context, String text, Widget page, Color color) {
    return SizedBox(
      width: 200,
      height: 50,
      child: ElevatedButton(
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => page)),
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: color,
        ),
        child: Text(text),
      ),
    );
  }
}
