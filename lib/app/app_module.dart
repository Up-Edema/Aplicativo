import 'package:flutter_modular/flutter_modular.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:up_edema/app/modules/auth/auth_module.dart';
import 'package:up_edema/app/modules/home/home_module.dart';
import 'package:up_edema/app/shared/services/shared_prefs_service.dart';

class AppModule extends Module {
  @override
  void binds(i) {
    // i.addSingleton<SupabaseClient>(
    //   () => Supabase.instance.client,
    // );

    i.addSingleton<SharedPrefsService>(
      SharedPrefsService.new,
    );
  }

  @override
  void routes(r) {
    r.module('/', module: HomeModule());
    r.module('/auth/', module: AuthModule());
  }
}
