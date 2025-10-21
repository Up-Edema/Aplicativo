import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:up_edema/app/modules/auth/domain/exceptions/auth_exceptions.dart';
import 'package:up_edema/app/modules/auth/domain/models/create_user_model.dart';
import 'package:up_edema/app/modules/auth/presenters/stores/signup_store.dart';
import 'package:up_edema/app/modules/auth/presenters/widgets/auth_field_widget.dart';
import 'package:up_edema/app/modules/auth/presenters/widgets/auth_validator_widget.dart';
import 'package:up_edema/app/modules/core/formatters/mask_input_formatters.dart';
import 'package:up_edema/app/modules/core/mixins/mixin-validators.dart';
import 'package:up_edema/app/widgets/app_button.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage>
    with ValidationMixin {
  final SignUpStore store = Modular.get<SignUpStore>();

  final _formKey = GlobalKey<FormState>();
  final textMailController = TextEditingController();
  final textPasswordController = TextEditingController();
  final textConfirmPasswordController =
      TextEditingController();
  final textPhoneController = TextEditingController();

  late final FocusNode mailFocus;
  late final FocusNode passwordFocus;
  late final FocusNode confirmPasswordFocus;
  late final FocusNode phoneFocus;

  bool _hasEightCharacters = false;
  bool _hasUppercase = false;
  bool _hasNumber = false;
  bool _hasSpecialCharacter = false;

  @override
  void initState() {
    super.initState();
    mailFocus = FocusNode();
    passwordFocus = FocusNode();
    confirmPasswordFocus = FocusNode();
    phoneFocus = FocusNode();
  }

  @override
  void dispose() {
    textMailController.dispose();
    textPasswordController.dispose();
    textConfirmPasswordController.dispose();
    textPhoneController.dispose();
    mailFocus.dispose();
    passwordFocus.dispose();
    confirmPasswordFocus.dispose();
    phoneFocus.dispose();
    super.dispose();
  }

  void _validatePassword(String password) {
    setState(() {
      _hasEightCharacters = password.length >= 8;
      _hasUppercase = password.contains(RegExp(r'[A-Z]'));
      _hasNumber = password.contains(RegExp(r'[0-9]'));
      _hasSpecialCharacter = password.contains(
        RegExp(r'[!@#$%^&*(),.?":{}|<>]'),
      );
    });
  }

  void _submitForm() {
    final isFormValid =
        _formKey.currentState?.validate() ?? false;
    if (!isFormValid) return;

    final userRequest = UserCreateRequest(
      mail: textMailController.text,
      password: textPasswordController.text,
      phone: textPhoneController.text,
    );

    store.signUp(userRequest: userRequest);
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text("Criar Conta")),
      body: SafeArea(
        child: TripleListener<SignUpStore, String>(
          store: store,
          listener: (context, triple) {
            if (triple.error != null &&
                triple.error is AuthException) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    (triple.error as AuthException).message,
                  ),
                  backgroundColor: Colors.redAccent,
                ),
              );
            }
            if (triple.state.isNotEmpty) {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (_) => AlertDialog(
                  title: const Text('Sucesso!'),
                  content: Text(triple.state),
                  actions: [
                    TextButton(
                      child: const Text('OK'),
                      onPressed: () => Modular.to.popUntil(
                        ModalRoute.withName('/login/'),
                      ),
                    ),
                  ],
                ),
              );
            }
          },
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 16,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 5),
                  Text(
                    "Preencha seus dados abaixo para acessar a plataforma",
                    style: textTheme.titleMedium?.copyWith(
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 35),
                  CustomTextFormField(
                    label: 'Email',
                    hintText: 'E-mail',
                    controller: textMailController,
                    prefixIcon: Iconsax.sms,
                    keyboardType:
                        TextInputType.emailAddress,
                    autovalidateMode:
                        AutovalidateMode.onUserInteraction,
                    focusNode: mailFocus,
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_) => FocusScope.of(
                      context,
                    ).requestFocus(phoneFocus),
                    validator: validateEmail,
                  ),
                  const SizedBox(height: 24),
                  CustomTextFormField(
                    label: 'Telefone',
                    hintText: '(00) 0000-0000',
                    controller: textPhoneController,
                    prefixIcon: Iconsax.call,
                    keyboardType: TextInputType.phone,
                    inputFormatters: [
                      PhoneInputFormatter(),
                    ],
                    focusNode: phoneFocus,
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_) => FocusScope.of(
                      context,
                    ).requestFocus(passwordFocus),
                  ),
                  const SizedBox(height: 24),
                  CustomTextFormField(
                    label: 'Nova Senha',
                    hintText: 'Senha',
                    controller: textPasswordController,
                    prefixIcon: Iconsax.lock,
                    obscureText: true,
                    onChanged: _validatePassword,
                    focusNode: passwordFocus,
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_) => FocusScope.of(
                      context,
                    ).requestFocus(confirmPasswordFocus),
                    validator: validatePassword,
                  ),
                  const SizedBox(height: 16),
                  ValidationCriteria(
                    text: 'Pelo menos 8 caracteres',
                    isValid: _hasEightCharacters,
                  ),
                  ValidationCriteria(
                    text: 'Pelo menos 1 letra maiúscula',
                    isValid: _hasUppercase,
                  ),
                  ValidationCriteria(
                    text: 'Pelo menos 1 número',
                    isValid: _hasNumber,
                  ),
                  ValidationCriteria(
                    text: 'Pelo menos 1 caractere especial',
                    isValid: _hasSpecialCharacter,
                  ),
                  const SizedBox(height: 16),
                  CustomTextFormField(
                    label: 'Confirmar Senha',
                    hintText: 'Senha',
                    controller:
                        textConfirmPasswordController,
                    prefixIcon: Iconsax.lock_1,
                    obscureText: true,
                    focusNode: confirmPasswordFocus,
                    textInputAction: TextInputAction.done,
                    onFieldSubmitted: (_) => _submitForm(),
                    validator: (value) =>
                        validateConfirmPassword(
                          value,
                          textPasswordController.text,
                        ),
                  ),
                  const SizedBox(height: 32),
                  ScopedBuilder<SignUpStore, String>(
                    store: store,
                    onLoading: (_) => PrimaryButton(
                      text: 'Criar Conta',
                      isLoading: true,
                      onPressed: _submitForm,
                      borderRadius: 10,
                    ),
                    onState: (_, __) => PrimaryButton(
                      text: 'Criar Conta',
                      isLoading: false,
                      onPressed: _submitForm,
                      borderRadius: 10,
                    ),
                  ),

                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.center,
                    children: [
                      Text(
                        "Já tem uma conta?",
                        style: textTheme.titleMedium,
                      ),
                      SecondaryButton(
                        text: 'Acessar',
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6.0,
                        ),
                        onPressed: () => Modular.to.pop(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
