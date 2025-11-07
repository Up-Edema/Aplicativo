import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:up_edema/app/modules/auth/presenters/widgets/auth_field_widget.dart';
import 'package:up_edema/app/modules/core/mixins/mixin-validators.dart';
import 'package:up_edema/app/utils/app_theme.dart';
import 'package:up_edema/app/widgets/app_button.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({super.key});

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage>
    with ValidationMixin {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  late final FocusNode _emailFocus;

  @override
  void initState() {
    super.initState();
    _emailFocus = FocusNode();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _emailFocus.dispose();
    super.dispose();
  }

  void _submit() {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) return;

    // TODO: integrar com fluxo de envio de link de recuperação se necessário
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Verifique seu e-mail para continuar.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.outline, width: 1.5),
                    ),
                    child: IconButton(
                      icon: const Icon(Iconsax.arrow_left_2),
                      color: theme.colorScheme.primary,
                      onPressed: () => context.pop(),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text('Redefinir Senha', style: theme.textTheme.displaySmall),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                'Informe um email e enviamos um link para recuperação da sua senha.',
                style: theme.textTheme.titleMedium,
              ),
              const SizedBox(height: 24),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextFormField(
                      label: 'Email',
                      hintText: 'seuemail@dominio.com',
                      controller: _emailController,
                      prefixIcon: Iconsax.sms,
                      keyboardType: TextInputType.emailAddress,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      focusNode: _emailFocus,
                      textInputAction: TextInputAction.done,
                      onFieldSubmitted: (_) => _submit(),
                      validator: validateEmail,
                    ),
                    const SizedBox(height: 24),
                    PrimaryButton(
                      text: 'Envie-me uma nova senha',
                      onPressed: _submit,
                      borderRadius: 10,
                    ),
                    const SizedBox(height: 16),
                    Center(
                      child: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Text(
                            'Entrar na Conta? ',
                            style: theme.textTheme.titleMedium,
                          ),
                          GestureDetector(
                            onTap: () => context.push('/auth'),
                            child: Text(
                              'Login',
                              style: theme.textTheme.labelLarge,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
