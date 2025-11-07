import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:up_edema/app/modules/auth/domain/models/user_login_model.dart';
import 'package:up_edema/app/modules/auth/presenters/stores/login_store.dart';
import 'package:up_edema/app/modules/auth/presenters/widgets/auth_field_widget.dart';
import 'package:up_edema/app/modules/core/mixins/mixin-validators.dart';
import 'package:up_edema/app/widgets/app_button.dart';
import 'package:up_edema/app/modules/core/config/service_locator.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with ValidationMixin {
  final LoginStore store = getIt<LoginStore>();

  final _formKey = GlobalKey<FormState>();
  final textMailController = TextEditingController();
  final textPasswordController = TextEditingController();

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

  void _submitForm() {
    final isFormValid = _formKey.currentState?.validate() ?? false;
    if (!isFormValid) return;

    final loginRequest = UserLoginModel(
      mail: textMailController.text,
      password: textPasswordController.text,
    );

    store.login(loginModel: loginRequest);
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: TripleListener<LoginStore, User?>(
          store: store,
          listener: (context, triple) {
            if (triple.state != null) {
              context.go('/home');
            }
            if (triple.error != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(triple.error!.message),
                  backgroundColor: Colors.redAccent,
                ),
              );
            }
          },
          child: TripleBuilder<LoginStore, User?>(
            store: store,
            builder: (_, triple) {
              return SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16,
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Login", style: textTheme.displaySmall),
                      const SizedBox(height: 12),
                      Text(
                        "Olá, bem-vindo de volta ao Up Edema",
                        style: textTheme.titleMedium?.copyWith(
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 40),
                      CustomTextFormField(
                        label: 'Email',
                        hintText: 'seuemail@dominio.com',
                        controller: textMailController,
                        prefixIcon: Iconsax.sms,
                        keyboardType: TextInputType.emailAddress,
                        autovalidateMode:
                            AutovalidateMode.onUserInteraction,
                        focusNode: mailFocus,
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) => FocusScope.of(
                          context,
                        ).requestFocus(passwordFocus),
                        validator: validateEmail,
                      ),
                      const SizedBox(height: 24),
                      CustomTextFormField(
                        label: 'Senha',
                        hintText: 'Senha',
                        controller: textPasswordController,
                        prefixIcon: Iconsax.lock_1,
                        obscureText: true,
                        focusNode: passwordFocus,
                        textInputAction: TextInputAction.done,
                        onFieldSubmitted: (_) => _submitForm(),
                        validator: validatePassword,
                      ),
                      const SizedBox(height: 16),
                      Align(
                        alignment: Alignment.centerRight,
                        child: SecondaryButton(
                          text: 'Esqueci minha senha?',
                          onPressed: () {},
                        ),
                      ),
                      const SizedBox(height: 32),
                      PrimaryButton(
                        text: 'Login',
                        isLoading: triple.isLoading,
                        onPressed: _submitForm,
                        borderRadius: 10,
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Não tem Conta?",
                            style: textTheme.titleMedium,
                          ),
                          SecondaryButton(
                            text: 'Cadastre-se',
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6.0,
                            ),
                            onPressed: () => context.push('/auth/register'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
