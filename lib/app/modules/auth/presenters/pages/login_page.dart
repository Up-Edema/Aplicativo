import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:up_edema/app/modules/auth/presenters/widgets/auth_field_widget.dart';
import 'package:up_edema/app/widgets/app_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() =>
      _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final textMailController =
      TextEditingController();
  final textPasswordController =
      TextEditingController();

  late final FocusNode mailFocus;
  late final FocusNode passwordFocus;

  @override
  void initState() {
    super.initState();
    mailFocus = FocusNode();
    passwordFocus = FocusNode();
  }

  @override
  void dispose() {
    textMailController.dispose();
    textPasswordController.dispose();
    mailFocus.dispose();
    passwordFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: 24.0,
            vertical: 16.0,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  "Login",
                  style: textTheme.displaySmall,
                ),
                const SizedBox(height: 12),
                Text(
                  "Olá, bem-vindo de volta ao Up Edma",
                  style: textTheme.titleMedium
                      ?.copyWith(fontSize: 16),
                ),
                const SizedBox(height: 40),
                CustomTextFormField(
                  label: 'Email',
                  hintText:
                      'seuemail@dominio.com',
                  controller: textMailController,
                  prefixIcon: Iconsax.sms,
                  keyboardType:
                      TextInputType.emailAddress,
                  focusNode: mailFocus,
                  textInputAction:
                      TextInputAction.next,
                  onFieldSubmitted: (_) {
                    FocusScope.of(
                      context,
                    ).requestFocus(passwordFocus);
                  },
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty) {
                      return 'Por favor, insira seu e-mail.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                CustomTextFormField(
                  label: 'Senha',
                  hintText: 'Senha',
                  controller:
                      textPasswordController,
                  prefixIcon: Iconsax.lock_1,
                  obscureText: true,
                  focusNode: passwordFocus,
                  textInputAction:
                      TextInputAction.done,
                  onFieldSubmitted: (_) {},
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty) {
                      return 'Por favor, insira sua senha.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                Align(
                  alignment:
                      Alignment.centerRight,
                  child: SecondaryButton(
                    text: 'Esqueci minha senha?',
                    onPressed: () {},
                  ),
                ),
                const SizedBox(height: 32),
                PrimaryButton(
                  text: 'Login',
                  onPressed: () {},
                  borderRadius: 10,
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.center,
                  children: [
                    Text(
                      "Não tem Conta?",
                      style:
                          textTheme.titleMedium,
                    ),
                    SecondaryButton(
                      text: 'Cadastre-se',
                      padding:
                          const EdgeInsets.symmetric(
                            horizontal: 6.0,
                          ),
                      onPressed: () => Modular.to
                          .pushNamed("register"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
