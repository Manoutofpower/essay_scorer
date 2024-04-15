import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'suggestionpage.dart';
import '../models/result.dart';
import 'taskspage.dart';

class ResultPage extends StatelessWidget {

  final Result result;
  final String userText;
  final ScrollController scrollController = ScrollController();

  ResultPage({Key? key, required this.result, required this.userText})
      : super(key: key);

  // UI
  @override
  Widget build(BuildContext context) {
    // Using Scaffold to create a page layout with an AppBar and Body
    return Scaffold(
      appBar: AppBar(
        title: Text('Result', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blueGrey,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => TasksPage())),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.lightbulb_outline, color: Colors.white),
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => SuggestionPage(result: result))),
            tooltip: 'Get Suggestions',
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 18.0, 16.0, 0.0),
              child: buildFirstCardWithFinalResult((result.contentScore +
                      result.coherenceScore +
                      result.lexicalScore +
                      result.grammarScore) /
                  4),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 14.0, 16.0, 0.0),
              child: _buildScoreCard(),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 15.0, 16.0, 0.0),
              child: _buildCorrectionCard(context),
            ),
          ],
        ),
      ),
    );
  }

  // Build Score
  Widget _buildScoreCard() {
    // Builds a card widget containing detailed scoring information
    return Card(
      color: Colors.blueGrey[900],
      child: Padding(
        padding: const EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _build2ndSectionTitle('Score Details'),
            _buildCustomScoreTable(),
          ],
        ),
      ),
    );
  }

  Widget _buildCorrectionCard(BuildContext context) {
    // Builds a card for displaying auto-correction results
    return Card(
      color: Colors.blueGrey[900],
      child: Padding(
        padding: const EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('Auto Correction Results'),
            Padding(
              padding: const EdgeInsets.only(top: 0.0),
              child: Container(
                constraints: BoxConstraints(maxHeight: 300),
                child: Scrollbar(
                  thumbVisibility: true,
                  thickness: 6.0,
                  radius: Radius.circular(10.0),
                  controller: scrollController,
                  child: SingleChildScrollView(
                    controller: scrollController,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(
                            fontSize: 16,
                            height: 2.0,
                            color: Colors.white70,
                          ),
                          children: _highlightErrors(context),
                        ),
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
    double fullScore = 9.0;
    double totalScore = (result.contentScore +
            result.coherenceScore +
            result.lexicalScore +
            result.grammarScore) /
        4;
    double percentage = totalScore / fullScore;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
      child: Card(
        color: Colors.blueGrey[900],
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Final Result',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              SizedBox(height: 16.0),
              Stack(
                children: [
                  Container(
                    height: 20,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.blueGrey[600],
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  FractionallySizedBox(
                    widthFactor: percentage,
                    child: Container(
                      height: 20,
                      decoration: BoxDecoration(
                        color: Colors.tealAccent[400],
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  '${totalScore.toStringAsFixed(1)}/9',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<TextSpan> _highlightErrors(BuildContext context) {
    List<TextSpan> spans = [];
    String remainingText = userText;
    int currentPosition = 0;

    for (final correction in result.autoCorrectionResults) {
      final int start = correction.offset;
      final int end = correction.offset + correction.length;
      if (start > currentPosition) {
        spans.add(TextSpan(
          text: remainingText.substring(currentPosition, start),
          style: TextStyle(color: Colors.white70),
        ));
      }
      spans.add(TextSpan(
        text: remainingText.substring(start, end),
        style: TextStyle(
          backgroundColor: Colors.cyanAccent.withOpacity(0.4),
          color: Colors.white,
        ),
        recognizer: TapGestureRecognizer()
          ..onTap = () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text('Suggestion'),
                content: Text(correction.replacements.isNotEmpty
                    ? correction.replacements.first
                    : 'No suggestion'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text('OK'),
                  ),
                ],
              ),
            );
          },
      ));
      currentPosition = end;
    }

    if (currentPosition < remainingText.length) {
      spans.add(TextSpan(
        text: remainingText.substring(currentPosition),
        style: TextStyle(color: Colors.white70),
      ));
    }

    return spans;
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 4.0),
      child: Text(
        title,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _build2ndSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 10.0),
      child: Text(
        title,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildCustomScoreTable() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildAspectScoreCard(
          'Content',
          result.contentScore,
          result.contentExplain,
        ),
        _buildAspectScoreCard(
          'Coherence',
          result.coherenceScore,
          result.coherenceExplain,
        ),
        _buildAspectScoreCard(
          'Lexical',
          result.lexicalScore,
          result.lexicalExplain,
        ),
        _buildAspectScoreCard(
          'Grammar',
          result.grammarScore,
          result.grammarExplain,
        ),
      ],
    );
  }

  Widget _buildAspectScoreCard(
      String aspect, double score, String explanation) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  aspect,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
              Text(
                score.toStringAsFixed(1),
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ],
          ),
          SizedBox(height: 10.0),
          buildCompleteScoreWidget(score),
          SizedBox(height: 10.0),
          Text(
            explanation,
            style: TextStyle(fontSize: 14, color: Colors.white70),
          ),
        ],
      ),
    );
  }

  Widget buildFirstCardWithFinalResult(double score) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0.0),
      child: Card(
        color: Colors.blueGrey[900],
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Final Result',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              SizedBox(height: 0),
              buildCompleteScoreWidget(score),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCompleteScoreWidget(double score) {
    double fullScore = 9.0;
    double percentage = score / fullScore;
    String formattedScore = score.toStringAsFixed(1);

    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
      child: Card(
        color: Colors.blueGrey[900],
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 8.0),
              Container(
                width: double.infinity,
                height: 10,
                decoration: BoxDecoration(
                  color: Colors.blueGrey[600],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: FractionallySizedBox(
                    widthFactor: percentage,
                    child: Container(
                      height: 10,
                      decoration: BoxDecoration(
                        color: Colors.tealAccent[400],
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                child: Center(
                  child: Text(
                    '$formattedScore/9',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
