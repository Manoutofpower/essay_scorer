import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

import '../models/result.dart';
import 'taskspage.dart';

class ResultPage extends StatelessWidget {
  final Result result;
  final String userText;
  final ScrollController scrollController = ScrollController();

  ResultPage({Key? key, required this.result, required this.userText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Result'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => TasksPage())),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: buildScoreComparisonProgressBar(result),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: _buildScoreCard(),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: _buildCorrectionCard(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScoreCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Score Details'),
            _buildCustomScoreTable(),
          ],
        ),
      ),
    );
  }

  Widget _buildCorrectionCard(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Auto Correction Results'),
            Padding(
              padding: const EdgeInsets.only(top: 0.0),
              child: Container(
                constraints: BoxConstraints(maxHeight: 300),
                child: Scrollbar(
                  thumbVisibility: true,
                  controller: scrollController,
                  child: SingleChildScrollView(
                    controller: scrollController,
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(fontSize: 16, height: 2.0),
                        children: _highlightErrors(context),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildScoreComparisonProgressBar(Result result) {
    double totalScore = (result.contentScore + result.coherenceScore + result.lexicalScore + result.grammarScore) / 4;
    return LinearProgressIndicator(value: totalScore / 9.0);
  }

  List<TextSpan> _highlightErrors(BuildContext context) {
    List<TextSpan> spans = [];
    String remainingText = userText;
    int currentPosition = 0;

    for (final correction in result.autoCorrectionResults) {
      final int start = correction.offset;
      final int end = correction.offset + correction.length;
      if (start > currentPosition) {
        spans.add(TextSpan(text: remainingText.substring(currentPosition, start)));
      }
      spans.add(TextSpan(
        text: remainingText.substring(start, end),
        style: TextStyle(backgroundColor: Colors.cyanAccent.withOpacity(0.4)),
        recognizer: TapGestureRecognizer()..onTap = () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Suggestion'),
              content: Text(correction.replacements.isNotEmpty ? correction.replacements.first : 'No suggestion'),
            ),
          );
        },
      ));
      currentPosition = end;
    }

    if (currentPosition < remainingText.length) {
      spans.add(TextSpan(text: remainingText.substring(currentPosition)));
    }

    return spans;
  }

  Widget _buildCustomScoreTable() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildAspectScoreCard('Content', result.contentScore, result.contentExplain),
        _buildAspectScoreCard('Coherence', result.coherenceScore, result.coherenceExplain),
        _buildAspectScoreCard('Lexical', result.lexicalScore, result.lexicalExplain),
        _buildAspectScoreCard('Grammar', result.grammarScore, result.grammarExplain),
      ],
    );
  }

  Widget _buildAspectScoreCard(String aspect, double score, String explanation) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: Text(aspect)),
              Text(score.toStringAsFixed(1)),
            ],
          ),
          SizedBox(height: 10.0),
          LinearProgressIndicator(value: score / 9.0),
          SizedBox(height: 10.0),
          Text(explanation),
        ],
      ),
    );
  }
}
