class Quiz {
  final String goodParagraph;
  final String badParagraph;
  final String goodExplanation;
  final String badExplanation;

  Quiz({required this.goodParagraph, required this.badParagraph, required this.goodExplanation, required this.badExplanation});
}

final List<Quiz> quizzes = [
  Quiz(
    goodParagraph: "The proliferation of technology has transformed modern society, offering unprecedented convenience and efficiency in daily tasks. Particularly in education, online platforms have democratized access to knowledge, enabling learners from remote areas to pursue their academic interests.",
    badParagraph: "Technology is very helpful in our life and makes things like learning and work easier. For example, people can learn on the internet.",
    goodExplanation: "Coherence: The good paragraph clearly outlines the impact of technology with specific examples. Lexical: It employs a diverse vocabulary that accurately conveys complex ideas. Grammar: The sentence structure is varied and grammatically correct.",
    badExplanation: "Coherence: The bad paragraph lacks detailed examples and fails to fully develop the idea. Lexical: The vocabulary is repetitive and basic, not effectively conveying nuanced thoughts. Grammar: The paragraph uses simple sentence structures, limiting the expression of complex ideas.",
  ),
  Quiz(
    goodParagraph: "Globalization has fostered cultural exchange and understanding, enriching societies by introducing them to foreign customs and traditions. This cultural amalgamation has spurred innovation in culinary arts, fashion, and even in the workplace, promoting a more inclusive global community.",
    badParagraph: "Globalization is good because it makes different cultures come together. People get to know more about other cultures and this is very interesting.",
    goodExplanation: "Coherence: The good paragraph provides a cogent argument with concrete examples of globalization's impact on culture. Lexical: A rich lexicon is used to discuss the nuances of cultural exchange. Grammar: Complex grammatical structures are correctly utilized, enhancing the clarity and sophistication of the argument.",
    badExplanation: "Coherence: The bad paragraph presents a vague and undeveloped idea of cultural exchange. Lexical: The use of a limited and repetitive vocabulary fails to capture the depth of cultural interactions. Grammar: Predominantly simple sentences are used, which do not allow for the detailed exploration of the topic.",
  ),
  // Add more quizzes as needed
];
