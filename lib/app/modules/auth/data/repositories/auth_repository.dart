import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:up_edema/app/modules/auth/domain/exceptions/auth_exceptions.dart'
    hide AuthException;
import 'package:up_edema/app/modules/auth/domain/models/create_user_model.dart';

abstract class IAuthrepository {
  Future<void> signUp({
    required UserCreateRequest userRequestModel,
  });
}

class AuthRepository implements IAuthrepository {
  final SupabaseClient _supabaseClient =
      Supabase.instance.client;

  @override
  Future<void> signUp({
    required UserCreateRequest userRequestModel,
  }) async {
    try {
      await _supabaseClient.auth.signUp(
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
}
