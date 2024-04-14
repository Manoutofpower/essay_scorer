class AutoCorrectionResult {
  final String message;
  final String shortMessage;
  final List<String> replacements;
  final String contextText;
  final int offset;
  final int length;

  AutoCorrectionResult({
    required this.message,
    required this.shortMessage,
    required this.replacements,
    required this.contextText,
    required this.offset,
    required this.length,
  });

  factory AutoCorrectionResult.fromJson(Map<String, dynamic> json) {
    List<String> replacements = (json['replacements'] as List)
        .map((e) => e['value'] as String)
        .toList();

    return AutoCorrectionResult(
      message: json['message'],
      shortMessage: json['shortMessage'],
      replacements: replacements,
      contextText: json['context']['text'],
      offset: json['offset'],
      length: json['length'],
    );
  }
}

class Result {
  final double contentScore;
  final String contentExplain;
  final double coherenceScore;
  final String coherenceExplain;
  final double lexicalScore;
  final String lexicalExplain;
  final double grammarScore;
  final String grammarExplain;
  final List<AutoCorrectionResult> autoCorrectionResults;

  Result({
    required this.contentScore,
    required this.contentExplain,
    required this.coherenceScore,
    required this.coherenceExplain,
    required this.lexicalScore,
    required this.lexicalExplain,
    required this.grammarScore,
    required this.grammarExplain,
    required this.autoCorrectionResults,
  });

  factory Result.fromJson(Map<String, dynamic> json) {
    List<AutoCorrectionResult> autoCorrections = [];
    if (json['autoCorrectionResults'] != null) {
      autoCorrections = (json['autoCorrectionResults'] as List)
          .map((e) => AutoCorrectionResult.fromJson(e as Map<String, dynamic>))
          .toList();
    }

    double parseScore(dynamic value) {
      try {
        if (value is int) {
          return value.toDouble();
        } else if (value is String) {
          return double.parse(value);
        } else {
          return (value as double);
        }
      } catch (e) {
        print('Failed to parse score: $e');
        return 0.0;
      }
    }

    return Result(
      contentScore: parseScore(json['content']['score']),
      contentExplain: json['content']['explain'] ?? '',
      coherenceScore: parseScore(json['coherence']['score']),
      coherenceExplain: json['coherence']['explain'] ?? '',
      lexicalScore: parseScore(json['lexical']['score']),
      lexicalExplain: json['lexical']['explain'] ?? '',
      grammarScore: parseScore(json['grammar']['score']),
      grammarExplain: json['grammar']['explain'] ?? '',
      autoCorrectionResults: autoCorrections,
    );
  }

}
