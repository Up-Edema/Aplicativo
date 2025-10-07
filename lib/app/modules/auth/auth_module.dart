import 'package:flutter_modular/flutter_modular.dart';
import 'package:up_edema/app/modules/auth/data/repositories/auth_repository.dart';
import 'package:up_edema/app/modules/auth/presenters/pages/login_page.dart';
import 'package:up_edema/app/modules/auth/presenters/pages/signup_page.dart';
import 'package:up_edema/app/modules/auth/presenters/stores/signup_store.dart';

class AuthModule extends Module {
  @override
  void binds(i) {
    i.addLazySingleton<IAuthrepository>(
      () => AuthRepository(),
    );

    i.addLazySingleton<SignUpStore>(
      () => SignUpStore(i<IAuthrepository>()),
    );
  }

  @override
  void routes(RouteManager r) {
    r.child(
      '/',
      child: (context) => const LoginPage(),
    );
    r.child(
      '/register',
      child: (context) => const SignUpPage(),
    );
  }
}
