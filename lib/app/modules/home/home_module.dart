import 'package:flutter_modular/flutter_modular.dart';
import 'package:up_edema/app/modules/home/presenters/home_page.dart';

class HomeModule extends Module {
  @override
  void binds(i) {}

  @override
  void routes(r) {
    r.child('/', child: (context) => const HomePage());
  }
}
