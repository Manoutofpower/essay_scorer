import 'package:flutter/material.dart';
import 'taskspage.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main Page'),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Center(
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TasksPage()),
              );
            },
            child: Text('Go to Tasks Page'),
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(home: MainPage()));
}
