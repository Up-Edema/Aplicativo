import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:up_edema/app/modules/auth/presenters/widgets/auth_field_widget.dart';
import 'package:up_edema/app/modules/core/mixins/mixin-validators.dart';
import 'package:up_edema/app/utils/app_theme.dart';
import 'package:up_edema/app/widgets/app_button.dart';

class ForgetChangePassword extends StatefulWidget {
  const ForgetChangePassword({super.key});

  @override
  State<ForgetChangePassword> createState() => _ForgetPageState();
}

class _ForgetPageState extends State<ForgetChangePassword>
    with ValidationMixin {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  late final FocusNode _newPasswordFocus;
  late final FocusNode _confirmPasswordFocus;

  @override
  void initState() {
    super.initState();
    _newPasswordFocus = FocusNode();
    _confirmPasswordFocus = FocusNode();
  }

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    _newPasswordFocus.dispose();
    _confirmPasswordFocus.dispose();
    super.dispose();
  }

  void _submit() {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) return;

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Solicitação enviada.')));
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
                      onPressed: () => Modular.to.pop(),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'Redefinir Nova Senha',
                    style: theme.textTheme.displaySmall,
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                'Preencha o campo abaixo para redefinir sua senha atual.',
                style: theme.textTheme.titleMedium,
              ),
              const SizedBox(height: 24),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextFormField(
                      label: 'Nova Senha',
                      hintText: 'Nova Senha',
                      controller: _newPasswordController,
                      prefixIcon: Iconsax.lock,
                      obscureText: true,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      focusNode: _newPasswordFocus,
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) =>
                          _confirmPasswordFocus.requestFocus(),
                      validator: validatePassword,
                    ),
                    const SizedBox(height: 24),
                    CustomTextFormField(
                      label: 'Confirma Senha',
                      hintText: 'Confirma Senha',
                      controller: _confirmPasswordController,
                      prefixIcon: Iconsax.lock_1,
                      obscureText: true,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      focusNode: _confirmPasswordFocus,
                      textInputAction: TextInputAction.done,
                      onFieldSubmitted: (_) => _submit(),
                      validator: (v) => validateConfirmPassword(
                        v,
                        _newPasswordController.text,
                      ),
                    ),
                    const SizedBox(height: 24),
                    PrimaryButton(
                      text: 'Confirmar redefinição de senha',
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
                            onTap: () => Modular.to.pushNamed('/auth/'),
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
