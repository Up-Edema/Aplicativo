import 'package:flutter_modular/flutter_modular.dart';
import 'package:up_edema/app/modules/quizzes/presenters/pages/continue_quizzes_page.dart';

class QuizzesModule extends Module {
  @override
  void binds(i) {}

  @override
  void routes(r) {
    r.child('/', child: (context) => const ContinueQuizzesPage());
  }
}