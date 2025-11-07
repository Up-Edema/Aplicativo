import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:up_edema/app/utils/app_theme.dart';
import 'package:up_edema/app/widgets/app_button.dart';

class VerificationAuthPage extends StatefulWidget {
  const VerificationAuthPage({super.key, this.email});

  final String? email;

  @override
  State<VerificationAuthPage> createState() => _VerificationAuthPageState();
}

class _VerificationAuthPageState extends State<VerificationAuthPage> {
  final int _otpLength = 4;
  late final List<TextEditingController> _controllers;
  late final List<FocusNode> _focusNodes;

  Timer? _timer;
  int _secondsRemaining = 60;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(_otpLength, (_) => TextEditingController());
    _focusNodes = List.generate(_otpLength, (_) => FocusNode());

    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (!mounted) return;
      setState(() {
        if (_secondsRemaining > 0) {
          _secondsRemaining--;
        } else {
          _timer?.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (final c in _controllers) c.dispose();
    for (final f in _focusNodes) f.dispose();
    super.dispose();
  }

  String _maskEmail(String email) {
    final atIndex = email.indexOf('@');
    if (atIndex <= 1) return email;
    final name = email.substring(0, atIndex);
    final domain = email.substring(atIndex);
    final visible = name.length >= 4
        ? name.substring(0, 4)
        : name.substring(0, 1);
    return '$visible****$domain';
  }

  String get _displayEmail {
    final fallback = 'maulana@gmail.com';
    final value = widget.email ?? fallback;
    return _maskEmail(value);
  }

  void _onChanged(int index, String value) {
    if (value.length == 1 && index < _otpLength - 1) {
      _focusNodes[index + 1].requestFocus();
    }
  }

  void _onBackspace(int index, RawKeyEvent event) {
    if (event is RawKeyDownEvent &&
        event.logicalKey == LogicalKeyboardKey.backspace) {
      if (_controllers[index].text.isEmpty && index > 0) {
        _focusNodes[index - 1].requestFocus();
      }
    }
  }

  String _collectCode() => _controllers.map((c) => c.text).join();

  void _submit() {
    final code = _collectCode();
    if (code.length != _otpLength) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Digite o código completo.')),
      );
      return;
    }
    // TODO: integrar verificação com backend
    context.go('/home');
  }

  void _resendCode() {
    if (_secondsRemaining == 0) {
      setState(() {
        _secondsRemaining = 60;
        _timer?.cancel();
        _timer = Timer.periodic(const Duration(seconds: 1), (t) {
          if (!mounted) return;
          setState(() {
            if (_secondsRemaining > 0) {
              _secondsRemaining--;
            } else {
              _timer?.cancel();
            }
          });
        });
      });
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Novo código enviado.')));
    }
  }

  Widget _otpBox(int index) {
    return SizedBox(
      width: 56,
      height: 56,
      child: RawKeyboardListener(
        focusNode: FocusNode(),
        onKey: (e) => _onBackspace(index, e),
        child: TextField(
          controller: _controllers[index],
          focusNode: _focusNodes[index],
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(1),
          ],
          decoration: InputDecoration(
            hintText: '-',
            filled: true,
            fillColor: AppColors.surface,
            contentPadding: const EdgeInsets.all(0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: AppColors.outline,
                width: 1.5,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: AppColors.outline,
                width: 1.5,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: AppColors.primary,
                width: 1.5,
              ),
            ),
          ),
          onChanged: (v) => _onChanged(index, v),
        ),
      ),
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
                  Text('Verificação OTP', style: theme.textTheme.displaySmall),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                'Enviamos um código de verificação para',
                style: theme.textTheme.titleMedium,
              ),
              const SizedBox(height: 6),
              Text(_displayEmail, style: theme.textTheme.titleLarge),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  _otpBox(0),
                  const SizedBox(width: 12),
                  _otpBox(1),
                  const SizedBox(width: 12),
                  _otpBox(2),
                  const SizedBox(width: 12),
                  _otpBox(3),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Text(
                    _secondsRemaining > 0
                        ? '0:${_secondsRemaining.toString().padLeft(2, '0')}'
                        : '0:00',
                    style: theme.textTheme.labelLarge,
                  ),
                  const SizedBox(width: 8),
                  TextButton(
                    onPressed: _secondsRemaining == 0 ? _resendCode : null,
                    child: const Text('Reenviar código?'),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              PrimaryButton(text: 'Entrar', onPressed: _submit),
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
                      onTap: () => context.push('/auth/'),
                      child: Text('Login', style: theme.textTheme.labelLarge),
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
