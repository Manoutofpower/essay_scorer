import 'package:flutter/material.dart';
import 'package:essay_scorer/models/QuesDetail.dart';
import 'package:essay_scorer/controller/service.dart';
import 'resultpage.dart';

class PracticePage extends StatefulWidget {
  final QuestionDetail questionDetail;

  PracticePage({Key? key, required this.questionDetail}) : super(key: key);

  @override
  _PracticePageState createState() => _PracticePageState();
}

class _PracticePageState extends State<PracticePage> {
  final TextEditingController _answerController = TextEditingController();
  int _wordCount = 0;

  @override
  void initState() {
    super.initState();
    _answerController.addListener(_updateWordCount);
  }

  @override
  void dispose() {
    _answerController.removeListener(_updateWordCount);
    _answerController.dispose();
    super.dispose();
  }

  void _updateWordCount() {
    setState(() {
      _wordCount = _answerController.text
          .split(RegExp(r'\s+'))
          .where((element) => element.isNotEmpty)
          .length;
    });
  }

  void _submitAnswer() async {
    final answer = _answerController.text;
    if (answer.isNotEmpty) {
      try {
        final QuestionService service = QuestionService();
        final result =
        await service.submitAnswer(answer, widget.questionDetail.topic);
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ResultPage(result: result, userText: answer),
        ));
      } catch (e) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Practice')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Card(
              elevation: 4.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.questionDetail.title, style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold)),
                    SizedBox(height: 10.0),
                    Text(widget.questionDetail.main, style: TextStyle(fontSize: 18.0)),
                    SizedBox(height: 20.0),
                    TextField(
                      controller: _answerController,
                      maxLines: 10,
                      decoration: InputDecoration(
                        hintText: 'Enter your answer here',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Text("Word Count: $_wordCount"),
                    SizedBox(height: 20.0),
                    ElevatedButton(
                      onPressed: _submitAnswer,
                      child: Text('Submit'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
