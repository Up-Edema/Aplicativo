import 'package:email_validator/email_validator.dart';

mixin ValidationMixin {
  String? validateNotEmpty(
    String? value,
    String fieldName,
  ) {
    if (value == null || value.isEmpty) {
      return 'O campo $fieldName é obrigatório.';
    }
    return null;
  }

  String? validateEmail(String? value) {
    final notEmptyValidation = validateNotEmpty(
      value,
      'E-mail',
    );
    if (notEmptyValidation != null) {
      return notEmptyValidation;
    }
    if (!EmailValidator.validate(value!)) {
      return 'Por favor, insira um e-mail válido.';
    }
    return null;
  }

  String? validatePassword(String? value) {
    final notEmptyValidation = validateNotEmpty(
      value,
      'Senha',
    );
    if (notEmptyValidation != null) {
      return notEmptyValidation;
    }
    if (value!.length < 8) {
      return 'A senha deve ter pelo menos 8 caracteres.';
    }
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'A senha deve conter pelo menos uma letra maiúscula.';
    }
    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'A senha deve conter pelo menos um número.';
    }
    if (!value.contains(
      RegExp(r'[!@#$%^&*(),.?":{}|<>]'),
    )) {
      return 'A senha deve conter pelo menos um caractere especial.';
    }
    return null;
  }

  String? validateConfirmPassword(
    String? value,
    String originalPassword,
  ) {
    final notEmptyValidation = validateNotEmpty(
      value,
      'Confirmação de Senha',
    );
    if (notEmptyValidation != null) {
      return notEmptyValidation;
    }
    if (value != originalPassword) {
      return 'As senhas não coincidem.';
    }
    return null;
  }
}
