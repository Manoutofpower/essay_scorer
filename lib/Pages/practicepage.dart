import 'dart:async';
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

  Timer? _timer;

  int _secondsElapsed = 0;

  final Color cardColor = Colors.blueGrey[900]!;
  final Color textColor = Colors.white70;
  final Color appBarColor = Colors.blueGrey;
  final Color buttonColor = Colors.green;


  @override
  void initState() {
    super.initState();
    _answerController.addListener(_updateWordCount);
    _startTimer();
  }


  @override
  void dispose() {
    _answerController.removeListener(_updateWordCount);
    _answerController.dispose();
    _timer?.cancel();
    super.dispose();
  }


  void _startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(oneSec, (timer) {
      if (_secondsElapsed == 900) {
        Navigator.of(context).pop();
      } else {
        setState(() {
          _secondsElapsed++;
        });
      }
    });
  }

  String _formatTime(int totalSeconds) {
    int minutes = totalSeconds ~/ 60;
    int seconds = totalSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
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
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(child: CircularProgressIndicator()),
      );
      try {
        final QuestionService service = QuestionService();
        final result =
        await service.submitAnswer(answer, widget.questionDetail.topic);
        Navigator.of(context).pop();
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ResultPage(result: result, userText: answer),
        ));
      } catch (e) {
        Navigator.of(context).pop();
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Practice', style: TextStyle(color: textColor)),
        backgroundColor: appBarColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Card(
                color: cardColor,
                elevation: 4.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 64.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        widget.questionDetail.title,
                        style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                            color: textColor),
                      ),
                      SizedBox(height: 10.0),
                      Text(
                        widget.questionDetail.main,
                        style: TextStyle(fontSize: 18.0, color: textColor),
                      ),
                      SizedBox(height: 20.0),
                      TextField(
                        controller: _answerController,
                        maxLines: 10,
                        decoration: InputDecoration(
                          hintText: 'Enter your answer here',
                          hintStyle:
                          TextStyle(color: textColor.withOpacity(0.7)),
                          border: OutlineInputBorder(),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: textColor.withOpacity(0.5)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: textColor),
                          ),
                        ),
                        style: TextStyle(color: textColor),
                      ),
                      SizedBox(height: 20.0),
                      Text("Word Count: $_wordCount",
                          style: TextStyle(fontSize: 16.0, color: textColor)),
                      SizedBox(height: 8.0),
                      Text('Timer: ${_formatTime(_secondsElapsed)}',
                          style: TextStyle(fontSize: 16.0, color: textColor)),
                      SizedBox(height: 20.0),
                      Align(
                        alignment: Alignment.center,
                        child: ElevatedButton(
                          onPressed: _submitAnswer,
                          style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 15)),
                          child:
                          Text('Submit', style: TextStyle(fontSize: 16.0)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 15.0),
            ],
          ),
        ),
      ),
    );
  }
}
