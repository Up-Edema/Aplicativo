import 'package:flutter_modular/flutter_modular.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CoreModule extends Module {
  @override
  void binds(i) {
    i.addSingleton<SupabaseClient>(
      (i) => Supabase.instance.client,
    );
  }
}
