import 'dart:math';
import 'package:flutter/material.dart';
import '../models/quizquestions.dart';

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  late Quiz selectedQuiz;
  String? selectedAnswer;
  bool isSubmitted = false;
  @override
  void initState() {
    super.initState();
    selectedQuiz = quizzes[Random().nextInt(quizzes.length)];
  }

  void submitAnswer() {
    if (!isSubmitted) {
      setState(() {
        isSubmitted = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Quiz"),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: <Widget>[
          Text(
            "Which paragraph is better?",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          ListTile(
            title: Text("Good"),
            subtitle: Text(selectedQuiz.goodParagraph),
            leading: Radio<String>(
              value: "Good",
              groupValue: selectedAnswer,
              onChanged: isSubmitted ? null : (value) {
                setState(() {
                  selectedAnswer = value;
                });
              },
            ),
          ),
          ListTile(
            title: Text("Bad"),
            subtitle: Text(selectedQuiz.badParagraph),
            leading: Radio<String>(
              value: "Bad",
              groupValue: selectedAnswer,
              onChanged: isSubmitted ? null : (value) {
                setState(() {
                  selectedAnswer = value;
                });
              },
            ),
          ),
          ElevatedButton(
            onPressed: isSubmitted ? null : submitAnswer,
            child: Text("Submit"),
          ),
          if (isSubmitted)
            Text(
              "Your choice is: ${selectedAnswer == "Good" ? "Correct" : "Incorrect"}",
            ),
        ],
      ),
    );
  }
}
