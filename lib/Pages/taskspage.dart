import 'package:essay_scorer/Pages/practicepage.dart';
import 'package:flutter/material.dart';
import 'package:essay_scorer/models/question.dart';
import 'package:essay_scorer/controller/service.dart';
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
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Write Essay'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => MainPage()),
                  (Route<dynamic> route) => false,
            );
          },
        ),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: questions.length,
          itemBuilder: (context, index) {
            final question = questions[index];
            return Card(
              margin: EdgeInsets.symmetric(vertical: 8),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              child: ListTile(
                title: Text(question.quesTitle),
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
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error loading question details.")));
    }
  }
}
