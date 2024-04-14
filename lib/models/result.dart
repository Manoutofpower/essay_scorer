class Result {
  final double contentScore;
  final String contentExplain;
  final double coherenceScore;
  final String coherenceExplain;
  final double lexicalScore;
  final String lexicalExplain;
  final double grammarScore;
  final String grammarExplain;
  Result({
    required this.contentScore,
    required this.contentExplain,
    required this.coherenceScore,
    required this.coherenceExplain,
    required this.lexicalScore,
    required this.lexicalExplain,
    required this.grammarScore,
    required this.grammarExplain,
  });

  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
      contentScore: (json['content']['score'] as num).toDouble(),
      contentExplain: json['content']['explain'],
      coherenceScore: (json['coherence']['score'] as num).toDouble(),
      coherenceExplain: json['coherence']['explain'],
      lexicalScore: (json['lexical']['score'] as num).toDouble(),
      lexicalExplain: json['lexical']['explain'],
      grammarScore: (json['grammar']['score'] as num).toDouble(),
      grammarExplain: json['grammar']['explain'],
    );
  }
}
