class QuestionDetail {
  final String title;
  final String main;
  final String topic;

  QuestionDetail({required this.title, required this.main, required this.topic});

  factory QuestionDetail.fromJson(Map<String, dynamic> json) {
    return QuestionDetail(
      title: json['qTitle'] ?? 'No title',
      main: json['qMain'] ?? 'No main content',
      topic: json['qTopic'] ?? 'No topic',
    );
  }
}
