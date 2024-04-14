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
      body: Container(

      ),
    );
  }
}
