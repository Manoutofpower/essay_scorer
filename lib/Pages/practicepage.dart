import 'package:flutter/material.dart';
import 'package:essay_scorer/models/QuesDetail.dart';  // 确保你有这个模型

class PracticePage extends StatelessWidget {
  final QuestionDetail questionDetail;  // 接收 QuestionDetail 对象

  PracticePage({Key? key, required this.questionDetail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Practice'),
      ),
      body: Center(
        child: Text('Practice Page'), // 你可以在这里显示问题的标题或其他信息
      ),
    );
  }
}
