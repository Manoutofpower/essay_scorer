import 'package:flutter/material.dart';
import 'userpage.dart';
import 'taskspage.dart'; // Import the task page

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MainPage'),
        automaticallyImplyLeading: false, // Remove the back button
        actions: <Widget>[
          IconButton(
            icon: CircleAvatar(
              backgroundImage:

                  AssetImage('image path'), // Image Path

            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UserPage()),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              // Adjust layout
              _buildHealthCard('Have Passed', '** Tasks', Icons.hotel_outlined),
              _buildHealthCard(
                  'Kept Learning', '** Days', Icons.directions_walk_outlined),
              SizedBox(height: 16),
              // Add spacing to separate buttons
              _buildCustomButton('Tasks', Icons.assignment, context),
              // Add a new custom button
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHealthCard(String title, String data, IconData icon) {
    return Card(
      child: ListTile(
        title: Text(title),
        subtitle: Text(data),
        leading: Icon(icon, size: 48), // Adjust icon size for regular display
      ),
    );
  }

  Widget _buildCustomButton(String title, IconData icon, BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => TasksPage()), // Navigate to the task page
        );
      },
      child: ListTile(
        title: Text(title),
        leading: Icon(icon),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(home: MainPage()));
}
