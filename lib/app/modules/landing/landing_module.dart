import 'package:flutter_modular/flutter_modular.dart';
import 'package:up_edema/app/modules/landing/presenters/pages/lading_page.dart';

class LandingModule extends Module {
  @override
  void binds(i) {}

  @override
  void routes(r) {
    r.child('/', child: (context) => LandingPage());
  }
}
