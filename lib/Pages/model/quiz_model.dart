class QuizQuestion {
  String type;
  String difficulty;
  String category;
  String question;
  String correctAnswer;
  List<String> incorrectAnswers;

  QuizQuestion({
    required this.type,
    required this.difficulty,
    required this.category,
    required this.question,
    required this.correctAnswer,
    required this.incorrectAnswers,
  });

  // Factory method to create an instance from a JSON object
  factory QuizQuestion.fromJson(Map<String, dynamic> json) {
    return QuizQuestion(
      type: json['type'] as String,
      difficulty: json['difficulty'] as String,
      category: json['category'] as String,
      question: json['question'] as String,
      correctAnswer: json['correct_answer'] as String,
      incorrectAnswers: List<String>.from(json['incorrect_answers']),
    );
  }

  // Method to convert an instance to a JSON object
  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'difficulty': difficulty,
      'category': category,
      'question': question,
      'correct_answer': correctAnswer,
      'incorrect_answers': incorrectAnswers,
    };
  }
}
