import 'package:flutter/material.dart';
import 'package:up_edema/app/modules/home/widgets/questionnaire_card.dart';

class ContinueQuizzesPage extends StatelessWidget {
  const ContinueQuizzesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Continue seus Questionários'),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: QuestionnaireCard(
            category: 'Etiologia',
            progressText: '22/32',
            title: 'Etiologia da anemia',
            subtitle: 'Questões Clínicas',
            progressValue: 0.75,
            onContinue: () {
              // Navegação ou ação para continuar o quiz
            },
          ),
        ),
        separatorBuilder: (context, index) => const SizedBox(height: 16),
        itemCount: 8,
      ),
    );
  }
}