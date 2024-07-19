import 'dart:convert';
import 'package:cta/Pages/model/quiz_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = 'https://opentdb.com/api.php?amount=10';

  ApiService();

  Future<List<QuizQuestion>> fetchQuizQuestions() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body)['results'];
      return data.map((json) => QuizQuestion.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load quiz questions');
    }
  }
}
