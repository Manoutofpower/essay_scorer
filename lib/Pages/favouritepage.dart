import 'package:flutter/material.dart';
import 'package:essay_scorer/models/question.dart';
import 'package:essay_scorer/global.dart';

class FavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Saved Questions'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: favoriteQuestions.length,
          itemBuilder: (context, index) {
            Question question = favoriteQuestions[index];
            return Card(
              child: ListTile(
                title: Text(question.quesTitle),
                onTap: () {
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
