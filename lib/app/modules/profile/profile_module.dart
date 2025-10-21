import 'package:flutter_modular/flutter_modular.dart';
import 'package:up_edema/app/modules/profile/presenters/profile.page.dart';

class ProfileModule extends Module {
  @override
  void binds(i) {}

  @override
  void routes(r) {
    r.child('/', child: (context) => const ProfilePage());
  }
}
