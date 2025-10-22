import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:up_edema/app/modules/core/config/service_locator.dart';

import 'app/app_module.dart';
import 'app/app_widget.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load();

  String supabaseUrl = dotenv.env['URL'] ?? '';
  String supabaseKey = dotenv.env['KEY'] ?? '';

  await Supabase.initialize(url: supabaseUrl, anonKey: supabaseKey);

  setupLocator();

  runApp(ModularApp(module: AppModule(), child: AppWidget()));
}
