import 'package:flutter/material.dart';
import 'package:essay_scorer/models/result.dart'; // 确保引入Result类

class ResultPage extends StatelessWidget {
  final Result result;
  final String userText;

  ResultPage({Key? key, required this.result, required this.userText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Result Page'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('User Answer:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text(userText, style: TextStyle(fontSize: 16)),
            Divider(height: 40, thickness: 2),
            Text('Scores and Explanations:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text('Content Score: ${result.contentScore}', style: TextStyle(fontSize: 16)),
            Text('Content Explanation: ${result.contentExplain}', style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text('Coherence Score: ${result.coherenceScore}', style: TextStyle(fontSize: 16)),
            Text('Coherence Explanation: ${result.coherenceExplain}', style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text('Lexical Score: ${result.lexicalScore}', style: TextStyle(fontSize: 16)),
            Text('Lexical Explanation: ${result.lexicalExplain}', style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text('Grammar Score: ${result.grammarScore}', style: TextStyle(fontSize: 16)),
            Text('Grammar Explanation: ${result.grammarExplain}', style: TextStyle(fontSize: 16)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }
}
