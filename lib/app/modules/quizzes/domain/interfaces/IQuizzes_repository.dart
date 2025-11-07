import 'package:up_edema/app/modules/quizzes/domain/models/quiz_models.dart';

abstract interface class IQuizzesRepository {
  Future<List<QuizModel>> fetchAllQuizzes();
  Future<QuizModel> fetchQuizById(String quizId);
}
