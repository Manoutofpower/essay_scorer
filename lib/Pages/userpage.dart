import 'package:flutter/material.dart';
import 'mainpage.dart';
import 'resetpwdpage.dart';

class UserPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('UserPage'),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ResetPwdPage()),
                    );
                  },
                  child: Text('Reset Pwd'),
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    _showResetAccountDialog(context);
                  },
                  child: Text('Reset Account'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showResetAccountDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Reset Account"),
          content: Text("Are you sure you want to reset the account?"),
          actions: <Widget>[
            TextButton(
              child: Text("Yes"),
              onPressed: () {
                //Logic to Reset Account should be here

                Navigator.of(context).pop(); // Close dialog
              },
            ),
            TextButton(
              child: Text("No"),
              onPressed: () {
                Navigator.of(context).pop(); // Close Dialog
              },
            ),
          ],
        );
      },
    );
  }
}

void main() {
  runApp(MaterialApp(home: MainPage()));
}
