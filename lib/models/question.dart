class Question {
  final String quesID;
  String quesTitle;

  Question({
    required this.quesID,
    required this.quesTitle,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      quesID: json['qID'].toString(),
      quesTitle: json['qTitle'] as String
    );
  }
}
