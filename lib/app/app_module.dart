import 'package:flutter_modular/flutter_modular.dart';
import 'package:up_edema/app/modules/auth/auth_module.dart';
import 'package:up_edema/app/modules/home/home_module.dart';
import 'package:up_edema/app/modules/landing/landing_module.dart';
import 'package:up_edema/app/modules/profile/profile_module.dart';
import 'package:up_edema/app/modules/splash/splash_module.dart';
import 'package:up_edema/app/modules/articles/articles_module.dart';
import 'package:up_edema/app/modules/quizzes/quizzes_module.dart';

class AppModule extends Module {
  @override
  void binds(i) {}

  @override
  void routes(r) {
    r.module('/', module: SplashModule());
    r.module('/landing/', module: LandingModule());
    r.module(
      '/auth/',
      module: AuthModule(),
      transition: TransitionType.rightToLeft,
    );
    r.module(
      '/home/',
      module: HomeModule(),
      transition: TransitionType.rightToLeftWithFade,
    );
    r.module('/profile/', module: ProfileModule());
    r.module('/articles/', module: ArticlesModule());
    r.module('/quizzes/', module: QuizzesModule());
  }
}
