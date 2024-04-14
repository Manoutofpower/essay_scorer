import 'package:dio/dio.dart';
import 'package:essay_scorer/models/QuesDetail.dart';
import 'package:essay_scorer/models/question.dart';
import 'package:essay_scorer/models/result.dart';

class QuestionService {
  Dio _dio = Dio(BaseOptions(
      baseUrl: "https://trans.rticonsulting.com.au/"
  ));

  Future<List<Question>> fetchQuestions() async {
    try {
      final response = await _dio.post('/question/listing');
      final data = response.data['questions'] as List;
      List<Question> questions = data.map((json) => Question.fromJson(json)).toList();
      return questions;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<bool> login(String username, String password) async {
    try {
      Response response = await _dio.post(
        '/user/login',
        data: {
          'userName': username,
          'userPassword': password,
        },
      );

      if (response.data != null && response.data['status'] == 'OK') {
        print("Login successful. User ID: ${response.data['id']}");
        return true;
      } else {
        print("Login failed.");
        return false;
      }
    } catch (e) {
      print("Login error: $e");
      return false;
    }
  }

  Future<QuestionDetail> fetchQuestionDetail(String quesID) async {
    try {
      final response = await _dio.post(
        '/question/practice',
        data: {'quesID': quesID},
      );
      if (response.data['status'] == 'OK') {
        final questionMap = response.data['question'][0];
        return QuestionDetail.fromJson(questionMap);
      } else {
        throw Exception('Failed to fetch question detail');
      }
    } catch (e) {
      print(e);
      throw Exception('Failed to fetch question detail');
    }
  }

  Future<Result> submitAnswer(String answer, String topic) async {
    try {
      final response = await _dio.post(
        '/api/check',
        data: {'answer': answer, 'topic': topic},
      );
      return Result.fromJson(response.data);
    } catch (e) {
      print(e);
      throw Exception('Failed to submit answer');
    }
  }
}