import 'package:flutter/material.dart';
import '../models/result.dart';

class SuggestionPage extends StatefulWidget {
  final Result result;

  SuggestionPage({Key? key, required this.result}) : super(key: key);

  @override
  _SuggestionPageState createState() => _SuggestionPageState();
}

class _SuggestionPageState extends State<SuggestionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Suggestions'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(8.0),
        children: <Widget>[
          _buildCustomSuggestionCard(
            title: 'Content Improvement Suggestions',
            icon: Icons.lightbulb_outline,
            score: widget.result.contentScore,
            getSuggestions: _getContentSuggestions,
          ),
          _buildCustomSuggestionCard(
            title: 'Coherence Improvement Suggestions',
            icon: Icons.sync_alt,
            score: widget.result.coherenceScore,
            getSuggestions: _getCoherenceSuggestions,
          ),
          _buildCustomSuggestionCard(
            title: 'Lexical Resource Improvement Suggestions',
            icon: Icons.book,
            score: widget.result.lexicalScore,
            getSuggestions: _getLexicalSuggestions,
          ),
          _buildCustomSuggestionCard(
            title: 'Grammar Improvement Suggestions',
            icon: Icons.grade,
            score: widget.result.grammarScore,
            getSuggestions: _getGrammarSuggestions,
          ),
          _buildOverallSuggestionCard(),
        ],
      ),
    );
  }

  Widget _buildCustomSuggestionCard({
    required String title,
    required IconData icon,
    required double score,
    required List<String> Function(double) getSuggestions,
  }) {
    List<String> suggestions = getSuggestions(score);
    return Card(
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: suggestions.map((s) => Text('- $s')).toList(),
        ),
      ),
    );
  }

  List<String> _getContentSuggestions(double score) {

    return ['Content suggestion 1', 'Content suggestion 2'];
  }

  List<String> _getCoherenceSuggestions(double score) {
    return ['Coherence suggestion 1', 'Coherence suggestion 2'];
  }

  List<String> _getLexicalSuggestions(double score) {
    return ['Lexical suggestion 1', 'Lexical suggestion 2'];
  }

  List<String> _getGrammarSuggestions(double score) {
    return ['Grammar suggestion 1', 'Grammar suggestion 2'];
  }

  Widget _buildOverallSuggestionCard() {
    return Card(
      child: ListTile(
        title: Text('Overall suggestions'),
      ),
    );
  }
}
