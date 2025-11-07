import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:up_edema/app/modules/core/config/service_locator.dart';
import 'package:up_edema/app/modules/quizzes/domain/interfaces/IQuizzes_repository.dart';
import 'package:up_edema/app/modules/quizzes/domain/models/quiz_models.dart';

class QuizzesRepository implements IQuizzesRepository {
  SupabaseClient supabase = getIt<SupabaseClient>();

  static const String fullQuizQuery = '*, questions(*, options(*))';

  QuizzesRepository(this.supabase);

  @override
  Future<List<QuizModel>> fetchAllQuizzes() async {
    try {
      final response = await supabase.from('forms').select(fullQuizQuery);

      final quizzes = (response as List)
          .map((quizJson) => QuizModel.fromMap(quizJson))
          .toList();

      return quizzes;
    } on PostgrestException catch (e) {
      throw Exception('Falha ao carregar quizzes: ${e.message}');
    } catch (e) {
      throw Exception('Ocorreu um erro inesperado: $e');
    }
  }

  @override
  Future<QuizModel> fetchQuizById(String quizId) async {
    try {
      final response = await supabase
          .from('forms')
          .select(fullQuizQuery)
          .eq('id', quizId)
          .single();

      final quiz = QuizModel.fromMap(response);

      return quiz;
    } on PostgrestException catch (e) {
      if (e.code == 'PGRST116') {
        throw Exception('Quiz com ID $quizId não encontrado.');
      }
      print('Erro ao buscar quiz por ID (Supabase): ${e.message}');
      throw Exception('Falha ao carregar quiz: ${e.message}');
    } catch (e) {
      print('Erro ao buscar quiz por ID (Dart): $e');
      throw Exception('Ocorreu um erro inesperado: $e');
    }
  }
}
