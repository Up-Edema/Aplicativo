import 'package:flutter_modular/flutter_modular.dart';
import 'package:up_edema/app/modules/auth/data/repositories/auth_repository.dart';
import 'package:up_edema/app/modules/auth/domain/interfaces/IAuth_repository.dart';
import 'package:up_edema/app/modules/auth/presenters/pages/login_page.dart';
import 'package:up_edema/app/modules/auth/presenters/pages/signup_page.dart';
import 'package:up_edema/app/modules/auth/presenters/pages/verification_page.dart';
import 'package:up_edema/app/modules/auth/presenters/stores/login_store.dart';
import 'package:up_edema/app/modules/auth/presenters/stores/verification_store.dart';
import 'package:up_edema/app/modules/auth/presenters/stores/signup_store.dart';

class AuthModule extends Module {
  @override
  void binds(i) {
    i.addLazySingleton<IAuthrepository>(() => AuthRepository());

    i.addLazySingleton<SignUpStore>(
      () => SignUpStore(i.get<IAuthrepository>()),
    );
    i.addLazySingleton<LoginStore>(() => LoginStore(i.get<IAuthrepository>()));
    i.addLazySingleton<VerificationStore>(
      () => VerificationStore(i.get<IAuthrepository>()),
    );
  }

  @override
  void routes(RouteManager r) {
    r.child('/', child: (context) => const LoginPage());
    r.child('/register', child: (context) => const SignUpPage());
    r.child(
      '/verify',
      child: (context) {
        final email = r.args.data as String?;
        return OtpVerificationPage(email: email ?? '');
      },
    );
  }
}
