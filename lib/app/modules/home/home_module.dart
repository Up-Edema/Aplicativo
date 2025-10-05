import 'package:flutter_modular/flutter_modular.dart';
import 'package:up_edema/app/modules/home/presenter/pages/home_page.dart';

class HomeModule extends Module {
  @override
  void binds(i) {
    // i.addLazySingleton<HomeRepository>(HomeRepositoryImpl.new);
    // i.addLazySingleton<HomeViewModel>((i) => HomeViewModel(repository: i()));
  }

  @override
  void routes(r) {
    r.child('/', child: (context) => const HomePage());
  }
}
