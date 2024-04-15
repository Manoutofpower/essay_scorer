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
        title: Text('Suggestions', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blueGrey,
      ),
      body: Container(
        child: ListView(
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
    String feedbackText;
    Color feedbackColor;

    if (score <= 4) {
      feedbackText = 'Needs Significant Improvement';
      feedbackColor = Colors.red;
    } else if (score <= 6) {
      feedbackText = 'Needs Improvement';
      feedbackColor = Colors.orange;
    } else if (score <= 8) {
      feedbackText = 'Doing Well';
      feedbackColor = Colors.lightGreen;
    } else {
      feedbackText = 'Excellent';
      feedbackColor = Colors.green;
    }

    return Card(
      color: Colors.blueGrey[900],
      margin: EdgeInsets.only(top: 16.0),
      child: ListTile(
        leading: Icon(icon),
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              feedbackText,
              style: TextStyle(color: feedbackColor),
            ),
            ...suggestions.map((s) => Text('- $s')).toList(),
          ],
        ),
      ),
    );
  }

  List<String> _getContentSuggestions(double score) {
    if (score <= 4) {
      return [
        'Explore and memorize vocabulary related to your topic to enhance content relevance.',
        'Work on structuring your content more logically to improve clarity and coherence.',
      ];
    } else if (score == 5) {
      return [
        'Integrate more examples and evidence to support your points and add depth to your content.',
        'Enhance the introduction and conclusion sections for a stronger impact and clearer summarization.',
      ];
    } else if (score == 6) {
      return [
        'Ensure your content is engaging by adding questions, quotations, or interesting facts.',
        'Use transitions effectively to ensure a smooth flow of ideas throughout your content.',
      ];
    } else if (score == 7) {
      return [
        'Refine your argumentation by presenting counterarguments and refuting them to strengthen your position.',
        'Incorporate varied sentence structures to keep your content dynamic and engaging.',
      ];
    } else if (score >= 8) {
      return [
        'Your content is already strong; challenge yourself by exploring new perspectives and complex themes.',
        'Continue to enrich your content with detailed research, unique insights, and comprehensive analysis.',
      ];
    } else {
      // Default suggestions
      return [
        'Ensure your content clearly communicates your ideas and stays on topic.',
        'Review and refine your content for coherence and logical flow.',
      ];
    }
  }

  List<String> _getCoherenceSuggestions(double score) {
    if (score <= 4) {
      return [
        'Improve the logical flow of your ideas by outlining your content before writing.',
        'Practice using linking words and phrases to connect sentences and paragraphs more effectively.',
      ];
    } else if (score == 5) {
      return [
        'Ensure each paragraph has a clear main idea and that all sentences within it support that idea.',
        'Use a variety of transition words to guide the reader through your arguments and explanations.',
      ];
    } else if (score == 6) {
      return [
        'Review your content for any abrupt jumps or breaks in logic, ensuring a smooth flow of ideas.',
        'Experiment with different paragraph structures to better support and develop your main points.',
      ];
    } else if (score == 7) {
      return [
        'Enhance coherence by making sure each section of your content logically leads to the next.',
        'Refine the use of cohesive devices beyond basic conjunctions to add sophistication to your writing.',
      ];
    } else if (score >= 8) {
      return [
        'Your content shows excellent coherence; focus on fine-tuning the balance and pacing of information presented.',
        'Challenge yourself by incorporating more complex logical structures and nuanced transitions in your writing.',
      ];
    } else {
      // Default suggestions
      return [
        'Ensure your writing is organized and each part contributes to the overall argument or narrative.',
        'Continuously practice structuring your content in a way that makes it easy for readers to follow your thought process.',
      ];
    }
  }

  List<String> _getLexicalSuggestions(double score) {
    if (score <= 4) {
      return [
        'Engage more with the Academic Word List (AWL) to expand your vocabulary.',
        'Try to use less common vocabulary to express your ideas.',
      ];
    } else if (score == 5) {
      return [
        'Strengthen the use of synonyms to avoid repeating the same vocabulary.',
        'Learn and practice using different forms of vocabulary.',
      ];
    } else if (score == 6) {
      return [
        'Continue to expand your range of vocabulary, including both academic and non-academic fields.',
        'Pay attention to the accuracy of your vocabulary and its appropriateness in context.',
      ];
    } else if (score == 7) {
      return [
        'Try using more specialized or specific vocabulary for precise expression.',
        'Learn to use collocations and set phrases to enrich your expression.',
      ];
    } else if (score >= 8) {
      return [
        'Your use of vocabulary is already excellent; try to challenge yourself with more complex expressions and metaphors.',
        'Continue to practice diverse vocabulary usage to maintain the vitality of your lexicon.',
      ];
    } else {
      // Default suggestions
      return [
        'Please ensure you use appropriate vocabulary to express your ideas.',
        'Pay attention to the accuracy of the vocabulary used.',
      ];
    }
  }

  List<String> _getGrammarSuggestions(double score) {
    if (score <= 4) {
      return [
        'Review fundamental grammar rules, focusing on verb tenses and subject-verb agreement.',
        'Practice writing sentences in various tenses and ensure consistency throughout your content.',
      ];
    } else if (score == 5) {
      return [
        'Enhance your understanding of complex sentence structures, including the use of clauses and modifiers.',
        'Work on using correct punctuation to clarify meaning and improve readability.',
      ];
    } else if (score == 6) {
      return [
        'Refine your use of grammar by practicing indirect speech, conditional sentences, and subjunctive moods.',
        'Focus on eliminating common grammatical errors, such as misplaced modifiers or incorrect pronoun usage.',
      ];
    } else if (score == 7) {
      return [
        'Experiment with advanced grammatical structures to add variety and sophistication to your writing.',
        'Ensure precision in the use of articles, prepositions, and conjunctions for clearer expression.',
      ];
    } else if (score >= 8) {
      return [
        'Your grammatical accuracy is commendable; continue to refine your style by varying sentence structure and length.',
        'Challenge yourself with nuanced grammatical forms and idiomatic expressions to enhance your writing’s flair.',
      ];
    } else {
      // Default suggestions
      return [
        'Regularly review your writing for grammatical consistency and correctness.',
        'Consider seeking feedback on your grammar usage from teachers or through grammar checking tools.',
      ];
    }
  }

  Widget _buildOverallSuggestionCard() {
    double averageScore = (widget.result.contentScore + widget.result.coherenceScore + widget.result.lexicalScore + widget.result.grammarScore) / 4.0;
    String overallSuggestionText = averageScore < 6 ? 'Focus on improving the clarity and coherence of your expressions.' : 'Great job! Continue to refine your skills and explore new challenges.';

    return Card(
      color: Colors.blueGrey[900],
      child: ListTile(
        title: Text(overallSuggestionText, style: TextStyle(color: Colors.white70)),
      ),
    );
  }
}
