import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:up_edema/app/utils/app_theme.dart';
import 'package:up_edema/app/modules/splash/presenters/splage_page.dart';
import 'package:up_edema/app/modules/landing/presenters/pages/lading_page.dart';
import 'package:up_edema/app/modules/auth/presenters/pages/login_page.dart';
import 'package:up_edema/app/modules/auth/presenters/pages/signup_page.dart';
import 'package:up_edema/app/modules/home/presenters/home_page.dart';
import 'package:up_edema/app/modules/articles/presenters/pages/recent_articles_page.dart';
import 'package:up_edema/app/modules/quizzes/presenters/pages/quizzes_progress_page.dart';
import 'package:up_edema/app/modules/profile/presenters/profile.page.dart';
import 'package:up_edema/app/modules/profile/presenters/pages/personal_data_page.dart';
import 'package:up_edema/app/modules/auth/presenters/pages/verification_auth_page.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final router = GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(path: '/', builder: (context, state) => const SplashPage()),
        GoRoute(path: '/landing', builder: (context, state) => const LandingPage()),
        GoRoute(path: '/home', builder: (context, state) => const HomePage()),
        GoRoute(path: '/articles', builder: (context, state) => const RecentArticlesPage()),
        GoRoute(path: '/quizzes', builder: (context, state) => const QuizzesProgressPage()),
        GoRoute(path: '/profile', builder: (context, state) => const ProfilePage()),
        GoRoute(path: '/profile/personal', builder: (context, state) => const PersonalDataPage()),
        GoRoute(path: '/auth', builder: (context, state) => const LoginPage()),
        GoRoute(path: '/auth/register', builder: (context, state) => const SignUpPage()),
        GoRoute(path: '/auth/verify', builder: (context, state) => const VerificationAuthPage()),
      ],
    );
    return MaterialApp.router(
      title: 'Up Edema',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      routerConfig: router,
    );
  }
}
