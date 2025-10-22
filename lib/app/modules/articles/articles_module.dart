import 'package:flutter_modular/flutter_modular.dart';
import 'package:up_edema/app/modules/articles/presenters/pages/recent_articles_page.dart';

class ArticlesModule extends Module {
  @override
  void binds(i) {}

  @override
  void routes(r) {
    r.child('/', child: (context) => const RecentArticlesPage());
  }
}