import 'package:flutter/material.dart';
import 'suggestionpage.dart';
import '../global.dart';
import 'userpage.dart';
import 'taskspage.dart';
import 'favouritepage.dart';
import 'quizpage.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main Page', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blueGrey,
        automaticallyImplyLeading: false,
        actions: <Widget>[
          IconButton(
            icon: CircleAvatar(
              backgroundImage: AssetImage('assets/fanta.jpg'),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UserPage()),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.lightbulb_outline, color: Colors.white),
            onPressed: latestResult != null ? () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SuggestionPage(result: latestResult!)),
              );
            }
                : null,
            tooltip: 'Get Suggestions',
          ),
        ],
      ),
      backgroundColor: Colors.grey[850],
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 15,
            mainAxisSpacing: 15,
            childAspectRatio: 1.0,
            children: <Widget>[
              _buildCard('Have Passed', '** Tasks', Icons.hotel_outlined,
                  context, Colors.amber[400]!),
              _buildCard('Kept Learning', '$keptLearningDays Days',
                  Icons.directions_walk_outlined, context, Colors.orange[400]!),
              _buildCard('Tasks', '', Icons.assignment, context,
                  Colors.amberAccent[700]!, onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TasksPage()),
                    );
                  }),
              _buildCard(
                  'Saved Questions',
                  '${favoriteQuestions.length} questions',
                  Icons.bookmark,
                  context,
                  Colors.redAccent[400]!, onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FavoritesPage()),
                );
              }),
              _buildCard('Daily Improvement', '', Icons.lightbulb_outline,
                  context, Colors.lightBlueAccent[400]!, onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => QuizPage()),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCard(String title, String data, IconData icon,
      BuildContext context, Color iconColor,
      {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: Colors.blueGrey[900],
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 48, color: iconColor),
              SizedBox(height: 10),
              Text(title,
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white70)),
              if (data.isNotEmpty) SizedBox(height: 5),
              if (data.isNotEmpty)
                Text(data, style: TextStyle(color: Colors.white70)),
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
