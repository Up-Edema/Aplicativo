import 'package:flutter_triple/flutter_triple.dart';
import 'package:up_edema/app/modules/auth/domain/interfaces/IAuth_repository.dart';
import 'package:up_edema/app/modules/auth/domain/models/create_user_model.dart';

class SignUpStore extends Store<String> {
  final IAuthrepository _authRepository;

  SignUpStore(this._authRepository) : super('');

  Future<void> signUp({
    required UserCreateRequest userRequest,
  }) async {
    await execute(() async {
      await _authRepository.signUp(
        userRequestModel: userRequest,
      );
      return 'Cadastro realizado! Por favor, verifique seu e-mail para confirmar a conta.';
    });
  }
}
