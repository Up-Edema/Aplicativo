abstract class AuthException
    implements Exception {
  final String message;
  AuthException(this.message);

  @override
  String toString() => message;
}

class EmailAlreadyInUseException
    extends AuthException {
  EmailAlreadyInUseException()
    : super("Este e-mail já está em uso.");
}

class WeakPasswordException
    extends AuthException {
  WeakPasswordException()
    : super(
        "A senha é muito fraca. Use pelo menos 6 caracteres.",
      );
}

class InvalidCredentialsException
    extends AuthException {
  InvalidCredentialsException()
    : super("E-mail ou senha inválidos.");
}

class GenericAuthException extends AuthException {
  GenericAuthException(super.message);
}
