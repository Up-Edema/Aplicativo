import 'package:flutter/material.dart';
import 'package:up_edema/app/modules/core/config/service_locator.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:up_edema/app/modules/home/widgets/questionnaire_card.dart';
import 'package:up_edema/app/modules/quizzes/presenters/stores/quizzes_store.dart';
import 'package:up_edema/app/modules/quizzes/domain/models/quiz_models.dart';

class QuizzesProgressPage extends StatefulWidget {
  const QuizzesProgressPage({super.key});

  @override
  State<QuizzesProgressPage> createState() => _QuizzesProgressPageState();
}

class _QuizzesProgressPageState extends State<QuizzesProgressPage> {
  late final QuizzesStore store;

  @override
  void initState() {
    super.initState();
    store = getIt<QuizzesStore>();
    store.load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Questionários')),
      body: ScopedBuilder<QuizzesStore, QuizzesState>(
        store: store,
        onLoading: (context) =>
            const Center(child: CircularProgressIndicator()),
        onError: (context, error) => Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text('Erro ao carregar questionários: ${error.toString()}'),
          ),
        ),
        onState: (context, state) {
          final quizzes = state.quizzes;
          if (quizzes.isEmpty) {
            return const Center(child: Text('Nenhum questionário encontrado'));
          }
          return ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            itemCount: quizzes.length,
            separatorBuilder: (context, index) => const SizedBox(height: 16),
            itemBuilder: (context, index) {
              final QuizModel quiz = quizzes[index];
              final form = quiz.form;
              final category = form.category ?? 'Questionários';
              final title = form.title;
              final subtitle = form.subtitle ?? '';
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: QuestionnaireCard(
                  category: category,
                  progressText: '0/0',
                  title: title,
                  subtitle: subtitle.isEmpty ? 'Questões Clínicas' : subtitle,
                  progressValue: 0.0,
                  onContinue: () {
                    // Placeholder para continuar o quiz; rota detalhada pode ser adicionada futuramente
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
