import 'package:flutter_triple/flutter_triple.dart';
import 'package:up_edema/app/modules/quizzes/domain/interfaces/IQuizzes_repository.dart';
import 'package:up_edema/app/modules/quizzes/domain/models/quiz_models.dart';

class QuizzesState {
  final List<QuizModel> quizzes;
  final String? statusFilter;

  const QuizzesState({required this.quizzes, this.statusFilter});

  factory QuizzesState.initial() => const QuizzesState(quizzes: []);

  QuizzesState copyWith({List<QuizModel>? quizzes, String? statusFilter}) {
    return QuizzesState(
      quizzes: quizzes ?? this.quizzes,
      statusFilter: statusFilter ?? this.statusFilter,
    );
  }
}

class QuizzesStore extends Store<QuizzesState> {
  final IQuizzesRepository _repository;

  QuizzesStore(this._repository) : super(QuizzesState.initial());

  Future<void> load({String? statusFilter}) async {
    setLoading(true);
    try {
      final list = await _repository.fetchAllQuizzes();
      update(state.copyWith(quizzes: list, statusFilter: statusFilter));
    } catch (e) {
      setError(e);
    } finally {
      setLoading(false);
    }
  }

  Future<QuizModel?> getById(String formId) async {
    try {
      final idx = state.quizzes.indexWhere((q) => q.form.id == formId);
      if (idx != -1) return state.quizzes[idx];

      final quiz = await _repository.fetchQuizById(formId);
      update(state.copyWith(quizzes: [...state.quizzes, quiz]));
      return quiz;
    } catch (e) {
      setError(e);
      return null;
    }
  }
}
