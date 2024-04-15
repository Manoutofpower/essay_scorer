class Question {
  final String quesID;
  String quesTitle;
  bool isFavorited;

  Question({
    required this.quesID,
    required this.quesTitle,
    this.isFavorited = false,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      quesID: json['qID'].toString(),
      quesTitle: json['qTitle'] as String,
      isFavorited: json['isFavorited'] ?? false,
    );
  }

  void toggleFavorite() {
    isFavorited = !isFavorited;
  }
}
