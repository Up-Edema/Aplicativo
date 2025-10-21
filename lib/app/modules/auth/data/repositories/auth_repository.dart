import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:up_edema/app/modules/auth/domain/exceptions/auth_exceptions.dart'
    hide AuthException;
import 'package:up_edema/app/modules/auth/domain/interfaces/IAuth_repository.dart';
import 'package:up_edema/app/modules/auth/domain/models/create_user_model.dart';
import 'package:up_edema/app/modules/auth/domain/models/user_login_model.dart';
import 'package:up_edema/app/modules/core/config/service_locator.dart';

class AuthRepository implements IAuthrepository {
  final SupabaseClient supabaseClient =
      getIt<SupabaseClient>();

  @override
  Future<void> signUp({
    required UserCreateRequest userRequestModel,
  }) async {
    try {
      await supabaseClient.auth.signUp(
        email: userRequestModel.mail,
        password: userRequestModel.password,
        data: {'phone': userRequestModel.phone},
      );
    } on AuthException catch (e) {
      if (e.message.toLowerCase().contains(
        'user already registered',
      )) {
        throw EmailAlreadyInUseException();
      }
      if (e.message.toLowerCase().contains(
        'password should be at least 6 characters',
      )) {
        throw WeakPasswordException();
      }
      throw GenericAuthException(e.message);
    } catch (err) {
      throw Exception(
        "Ocorreu um erro inesperado. Tente novamente.",
      );
    }
  }

  @override
  Future<User> login({
    required UserLoginModel loginModel,
  }) async {
    try {
      final response = await supabaseClient.auth
          .signInWithPassword(
            email: loginModel.mail,
            password: loginModel.password,
          );
      if (response.user != null) {
        return response.user!;
      }
      throw GenericAuthException(
        "Falha ao autenticar o usuário.",
      );
    } on AuthException catch (e) {
      if (e.message ==
          'Invalid login credentials') {
        throw InvalidCredentialsException();
      }
      throw GenericAuthException(e.message);
    } catch (e) {
      throw GenericAuthException(
        "Ocorreu um erro inesperado. Tente novamente.",
      );
    }
  }

  @override
  Future<bool> isLoggedIn() async {
    bool hasLogged = false;

    final session =
        supabaseClient.auth.currentSession;

    hasLogged = session != null ? true : false;

    return hasLogged;
  }
}
