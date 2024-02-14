import 'package:flutter/material.dart';
import 'userpage.dart'; //

class ResetPwdPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reset Password'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: 'Enter Current Password',
                ),
              ),
              SizedBox(height: 20),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Enter New Password',
                ),
              ),
              SizedBox(height: 20), //
              TextField(
                decoration: InputDecoration(
                  labelText: 'Confirm New Password',
                ),
              ),
              SizedBox(height: 20), //
              ElevatedButton(
                onPressed: () {

                  //Logic for reset password

                },
                child: Text('Reset Password'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
