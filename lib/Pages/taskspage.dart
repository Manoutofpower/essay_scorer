import 'package:flutter/material.dart';
import 'package:essay_scorer/models/question.dart';
import 'package:essay_scorer/controller/service.dart';
import '../global.dart';
import 'practicepage.dart';
import 'mainpage.dart';

class TasksPage extends StatefulWidget {
  @override
  _TasksPageState createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  List<Question> questions = [];
  bool isLoading = true;
  final QuestionService _questionService = QuestionService();

  @override
  void initState() {
    super.initState();
    fetchQuestions();
  }

  Future<void> fetchQuestions() async {
    try {
      questions = await _questionService.fetchQuestions();
      for (var question in questions) {
        question.isFavorited = favoriteQuestions.any((q) => q.quesID == question.quesID);
      }
    } finally {
      setState(() => isLoading = false);
    }
  }

  void _toggleFavorite(Question question) {
    setState(() {
      question.toggleFavorite();
      if (question.isFavorited) {
        favoriteQuestions.add(question);
      } else {
        favoriteQuestions.removeWhere((q) => q.quesID == question.quesID);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Write Essay', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blueGrey,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => MainPage()),
                  (Route<dynamic> route) => false,
            );
          },
        ),// For a dark theme, adjust AppBar color to fit
      ), // Set the background to dark
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: questions.length,
          itemBuilder: (context, index) {
            final question = questions[index];
            return Card(
              color: Colors.blueGrey[900], // Dark card color
              elevation: 2,
              margin: EdgeInsets.symmetric(vertical: 8),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              child: ListTile(
                title: Text(question.quesTitle, style: TextStyle(color: Colors.white70)), // Text color for dark theme
                trailing: IconButton(
                  icon: Icon(question.isFavorited ? Icons.favorite : Icons.favorite_border, color: Colors.redAccent),
                  onPressed: () => _toggleFavorite(question),
                ),
                onTap: () => fetchAndNavigate(question.quesID),
              ),
            );
          },
        ),
      ),
    );
  }

  void fetchAndNavigate(String quesID) async {
    try {
      final questionDetail = await _questionService.fetchQuestionDetail(quesID);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => PracticePage(questionDetail: questionDetail)),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error loading question details.", style: TextStyle(color: Colors.white))));
    }
  }
}
