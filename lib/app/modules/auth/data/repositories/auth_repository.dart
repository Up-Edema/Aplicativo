import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:up_edema/app/modules/auth/domain/exceptions/auth_exceptions.dart'
    hide AuthException;
import 'package:up_edema/app/modules/auth/domain/interfaces/IAuth_repository.dart';
import 'package:up_edema/app/modules/auth/domain/models/create_user_model.dart';
import 'package:up_edema/app/modules/auth/domain/models/enum_status.dart';
import 'package:up_edema/app/modules/auth/domain/models/user_login_model.dart';
import 'package:up_edema/app/utils/utils.dart' show Utils;

class AuthRepository implements IAuthrepository {
  final SupabaseClient supabaseClient;

  AuthRepository(this.supabaseClient);

  @override
  Future<void> signUp({required UserCreateRequest userRequestModel}) async {
    try {
      final response = await supabaseClient.auth.signUp(
        email: userRequestModel.mail,
        password: userRequestModel.password,
        data: {
          'role': 'user',
          'phone': Utils.removeDiacritics(userRequestModel.phone),
        },
      );
    } on AuthException catch (e) {
      if (e.message.toLowerCase().contains('user already registered')) {
        throw EmailAlreadyInUseException();
      }
      if (e.message.toLowerCase().contains(
        'password should be at least 6 characters',
      )) {
        throw WeakPasswordException();
      }
      throw GenericAuthException(e.message);
    } catch (err) {
      throw Exception("Ocorreu um erro inesperado. Tente novamente.");
    }
  }

  @override
  Future<User> login({required UserLoginModel loginModel}) async {
    try {
      final response = await supabaseClient.auth.signInWithPassword(
        email: loginModel.mail,
        password: loginModel.password,
      );

      final currentUser = supabaseClient.auth.currentUser;
      if (currentUser != null) {
        final profile = await supabaseClient
            .from('profiles')
            .select('status')
            .eq('id', currentUser.id)
            .single();

        final statusString = (profile)['status'] as String?;
        final status = UserStatus.values.firstWhere(
          (e) => e.name == statusString,
          orElse: () => UserStatus.inactive,
        );

        if (status == UserStatus.active || status == 'Ativo') {
          return currentUser;
        } else {
          await supabaseClient.auth.signOut();
          throw GenericAuthException('Usuário inativo ou bloqueado.');
        }
      }

      throw GenericAuthException("Falha ao autenticar o usuário.");
    } on AuthException catch (e) {
      if (e.message == 'Invalid login credentials') {
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

    final session = supabaseClient.auth.currentSession;

    hasLogged = session != null ? true : false;

    return hasLogged;
  }

  @override
  Future<void> requestEmailVerificationCode({required String email}) async {
    // try {
    //   final currentUser = supabaseClient.auth.currentUser;

    //   final body = {
    //     'email': 'matheusrogato@gmail.com',
    //     if (currentUser?.id != null) 'user_id': currentUser!.id,
    //     'supabaseUrl': dotenv.env['URL']!,
    //   };

    //   final res = await supabaseClient.functions.invoke(
    //     'generate-email-code',
    //     body: body,
    //   );

    //   final data = res.data;
    //   if (data is Map && data['error'] != null) {
    //     throw GenericAuthException(data['error'].toString());
    //   }
    // } on AuthException catch (e) {
    //   throw GenericAuthException(e.message);
    // } catch (e) {
    //   throw GenericAuthException('Falha ao solicitar código de verificação.');
    // }
  }
}
