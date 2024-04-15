import 'package:flutter/material.dart';
import 'mainpage.dart';
import 'package:essay_scorer/controller/service.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  final QuestionService _questionService = QuestionService();

  Future<void> _login() async {
    setState(() {
      _isLoading = true;
    });

    String username = _usernameController.text;
    String password = _passwordController.text;

    bool loginSuccess = await _questionService.login(username, password);

    if (loginSuccess) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MainPage()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Login Failed', style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.redAccent,
        ),
      );
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[850],
      appBar: AppBar(
        title: Text('Login', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Card(
            color: Colors.grey[800],
            margin: EdgeInsets.all(20),
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  FlutterLogo(size: 80.0),
                  SizedBox(height: 30.0),
                  buildTextField(_usernameController, 'Username', Colors.teal[200]!, Colors.teal.shade200, Colors.teal.shade300),
                  SizedBox(height: 20.0),
                  buildTextField(_passwordController, 'Password', Colors.teal[200]!, Colors.teal.shade200, Colors.teal.shade300, isPassword: true),
                  SizedBox(height: 20.0),
                  buildForgotPasswordButton(),
                  SizedBox(height: 30.0),
                  buildLoginButton(),
                  buildSignUpButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  TextField buildTextField(TextEditingController controller, String label, Color labelColor, Color borderColor, Color focusedBorderColor, {bool isPassword = false}) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: labelColor),
        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: borderColor)),
        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: focusedBorderColor)),
      ),
      style: TextStyle(color: Colors.white70),
    );
  }

  Widget buildForgotPasswordButton() {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () {},
        child: Text('Forgot Password?', style: TextStyle(color: Colors.white70)),
      ),
    );
  }

  Widget buildLoginButton() {
    return _isLoading
        ? CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.teal[200]!))
        : ElevatedButton(
      style: ElevatedButton.styleFrom(primary: Colors.deepPurple[300], onPrimary: Colors.white),
      onPressed: _login,
      child: Text('Log In'),
    );
  }

  Widget buildSignUpButton() {
    return TextButton(
      onPressed: () {},
      child: Text("Don't have an account? Sign Up", style: TextStyle(color: Colors.white70)),
    );
  }
}
