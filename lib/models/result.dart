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
  final double contentScore; // 从 int 改为 double
  final String contentExplain;
  final double coherenceScore; // 从 int 改为 double
  final String coherenceExplain;
  final double lexicalScore; // 从 int 改为 double
  final String lexicalExplain;
  final double grammarScore; // 从 int 改为 double
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
    List<AutoCorrectionResult> autoCorrections = (json['autoCorrectionResult'] as List)
        .map((e) => AutoCorrectionResult.fromJson(e))
        .toList();

    // 修改计算方式以保留小数点
    double initialGrammarScore = 9 - autoCorrections.length.toDouble();
    double finalGrammarScore = (initialGrammarScore > 0) ? initialGrammarScore : 0;
    finalGrammarScore = finalGrammarScore.clamp(0, 9).toDouble() ?? 0.1; // 确保分数在0到9之间，并保持为double类型

    return Result(
      contentScore: (json['content']['score'] as num).toDouble() ?? 0.1,
      contentExplain: json['content']['explain'] ?? '',
      coherenceScore: (json['coherence']['score'] as num).toDouble() ?? 0.1,
      coherenceExplain: json['coherence']['explain'] ?? '',
      lexicalScore: (json['lexical']['score'] as num).toDouble() ?? 0.1,
      lexicalExplain: json['lexical']['explain'] ?? '',
      grammarScore: finalGrammarScore,
      grammarExplain: json['grammar']['explain'] ?? '',
      autoCorrectionResults: autoCorrections,
    );
  }
}
