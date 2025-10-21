import 'package:flutter_triple/flutter_triple.dart';
import 'package:supabase_flutter/supabase_flutter.dart'; // Para usar o tipo User
import 'package:up_edema/app/modules/auth/domain/interfaces/IAuth_repository.dart';
import 'package:up_edema/app/modules/auth/domain/models/user_login_model.dart';

class LoginStore extends Store<User?> {
  final IAuthrepository _authRepository;

  LoginStore(this._authRepository) : super(null);

  Future<void> login({
    required UserLoginModel loginModel,
  }) async {
    setLoading(true);
    try {
      final user = await _authRepository.login(
        loginModel: loginModel,
      );
      update(user);
    } on AuthException catch (err) {
      setError(err);
    } catch (err) {
      setError(err);
    } finally {
      setLoading(false);
    }
  }
}
