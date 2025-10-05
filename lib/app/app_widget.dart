import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:up_edema/app/utils/app_theme.dart';

class AppWidget
    extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Up Edema',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      routerConfig:
          Modular.routerConfig,
    );
  }
}
