import 'package:flutter/material.dart';
import 'resetpwdpage.dart';
import 'initialpage.dart';

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
              SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    _showLogOutDialog(context);
                  },
                  child: Text('Log Out'),
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

                // Reset ACCOUNT HERE

                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("No"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showLogOutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Log Out"),
          content: Text("Are you sure you want to log out?"),
          actions: <Widget>[
            TextButton(
              child: Text("Yes"),
              onPressed: () {
                Navigator.of(context).popUntil((route) => route.isFirst); //exit
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => InitialPage())
                );
              },
            ),
            TextButton(
              child: Text("No"),
              onPressed: () {
                    Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
