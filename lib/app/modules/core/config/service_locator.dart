import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:up_edema/app/modules/auth/domain/interfaces/IAuth_repository.dart';
import 'package:up_edema/app/modules/auth/data/repositories/auth_repository.dart';
import 'package:up_edema/app/modules/profile/domain/interfaces/IProfile_repository.dart';
import 'package:up_edema/app/modules/profile/data/repositories/profile_repository.dart';
import 'package:up_edema/app/modules/quizzes/domain/interfaces/IQuizzes_repository.dart';
import 'package:up_edema/app/modules/quizzes/data/repositories/quizzes_repository.dart';
import 'package:up_edema/app/modules/auth/presenters/stores/login_store.dart';
import 'package:up_edema/app/modules/auth/presenters/stores/signup_store.dart';
import 'package:up_edema/app/modules/auth/presenters/stores/verification_store.dart';
import 'package:up_edema/app/modules/profile/presenters/stores/personal_data_store.dart';
import 'package:up_edema/app/modules/quizzes/presenters/stores/quizzes_store.dart';

final getIt = GetIt.instance;
void setupLocator() {
  getIt.registerSingleton<SupabaseClient>(
    Supabase.instance.client,
  );


  getIt.registerLazySingleton<IAuthrepository>(() => AuthRepository(getIt<SupabaseClient>()));
  getIt.registerLazySingleton<IProfilerepository>(() => ProfileRepository(getIt<SupabaseClient>()));
  getIt.registerLazySingleton<IQuizzesRepository>(() => QuizzesRepository(getIt<SupabaseClient>()));
  getIt.registerLazySingleton<LoginStore>(() => LoginStore(getIt<IAuthrepository>()));
  getIt.registerLazySingleton<SignUpStore>(() => SignUpStore(getIt<IAuthrepository>()));
  getIt.registerLazySingleton<VerificationStore>(() => VerificationStore(getIt<IAuthrepository>()));
  getIt.registerLazySingleton<PersonalDataStore>(() => PersonalDataStore(getIt<IProfilerepository>()));
  getIt.registerLazySingleton<QuizzesStore>(() => QuizzesStore(getIt<IQuizzesRepository>()));
}
