import 'package:essay_scorer/global.dart';
import 'package:flutter/material.dart';
import 'userpage.dart';
import 'taskspage.dart';
import 'favouritepage.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main Page'),
        automaticallyImplyLeading: false,
        actions: <Widget>[
          IconButton(
            icon: CircleAvatar(
              backgroundImage: AssetImage('assets/fanta.jpg'),
            ),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => UserPage())),
          ),
          IconButton(
            icon: Icon(Icons.lightbulb_outline),
            onPressed: () {},
            tooltip: 'Get Suggestions',
          ),
        ],
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: <Widget>[
          _buildCard('Have Passed', '** Tasks', Icons.hotel_outlined, context),
          _buildCard('Kept Learning', '1 Days', Icons.directions_walk_outlined, context),
          _buildCard('Tasks', '', Icons.assignment, context, onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => TasksPage()))),
          _buildCard('Saved Questions', '${favoriteQuestions.length} questions', Icons.bookmark, context,  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => FavoritesPage()))),
          _buildCard('Daily Improvement', '', Icons.lightbulb_outline, context),
        ],
      ),
    );
  }

  Widget _buildCard(String title, String data, IconData icon, BuildContext context, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 48),
              Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
              Text(data),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(home: MainPage()));
}
