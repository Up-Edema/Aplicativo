import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:up_edema/app/modules/auth/presenters/stores/verification_store.dart';
import 'package:up_edema/app/utils/app_theme.dart';
import 'package:up_edema/app/widgets/app_button.dart';

class VerificationPage extends StatefulWidget {
  final String email;
  const VerificationPage({super.key, required this.email});

  @override
  State<VerificationPage> createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  final VerificationStore store = Modular.get<VerificationStore>();

  final _controllers = List.generate(4, (_) => TextEditingController());
  final _focusNodes = List.generate(4, (_) => FocusNode());
  Timer? _timer;
  int _seconds = 60;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (final c in _controllers) c.dispose();
    for (final f in _focusNodes) f.dispose();
    super.dispose();
  }

  void _startTimer() {
    _seconds = 60;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) return;
      setState(() {
        _seconds = _seconds - 1;
        if (_seconds <= 0) {
          _timer?.cancel();
        }
      });
    });
  }

  String _maskedEmail(String email) {
    final parts = email.split('@');
    if (parts.length != 2) return email;
    final name = parts[0];
    final domain = parts[1];
    final mask = name.length > 2
        ? '${name.substring(0, 2)}${'*' * (name.length - 2)}'
        : '${name.substring(0, 1)}*';
    return '$mask@$domain';
  }

  Future<void> _resend() async {
    if (_seconds > 0) return;
    await store.requestCode(email: widget.email);
    _startTimer();
  }

  Future<void> _verify() async {
    final code = _controllers.map((c) => c.text.trim()).join();
    if (code.length != 4) {
      _showDialog('Insira os 4 dígitos do código.');
      return;
    }
    await store.verifyCode(email: widget.email, code: code);
    final state = store.state;
    if (state == true) {
      Modular.to.pushReplacementNamed('/home/');
    }
  }

  void _showDialog(String message) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Verificação OTP'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Modular.to.pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Iconsax.arrow_left_2),
          onPressed: () => Modular.to.pop(),
        ),
        title: const Text('Verificação OTP'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Enviamos um código de verificação para',
              style: theme.textTheme.bodyMedium,
            ),
            const SizedBox(height: 4),
            Text(
              _maskedEmail(widget.email),
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(4, (i) => _otpBox(i)),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Text(
                  _seconds > 0
                      ? '0:${_seconds.toString().padLeft(2, '0')}'
                      : '00:00',
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: AppTheme.lightTheme.primaryColor,
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: _resend,
                  child: Text(
                    'Reenviar código?',
                    style: theme.textTheme.labelMedium,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            ScopedBuilder<VerificationStore, bool>(
              store: store,
              onError: (_, error) {
                _showDialog(error.toString());
                return const SizedBox.shrink();
              },
              onLoading: (_) => PrimaryButton(
                text: 'Entrar',
                isLoading: true,
                onPressed: _verify,
                borderRadius: 10,
              ),
              onState: (_, __) => PrimaryButton(
                text: 'Entrar',
                isLoading: false,
                onPressed: _verify,
                borderRadius: 10,
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Entrar na Conta? '),
                GestureDetector(
                  onTap: () => Modular.to.pushReplacementNamed('/auth/'),
                  child: Text(
                    'Login',
                    style: theme.textTheme.titleSmall?.copyWith(
                      color: AppTheme.lightTheme.primaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _otpBox(int index) {
    return SizedBox(
      width: 60,
      height: 60,
      child: TextField(
        controller: _controllers[index],
        focusNode: _focusNodes[index],
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        decoration: InputDecoration(
          counterText: '',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
        onChanged: (val) {
          if (val.isNotEmpty && index < 3) {
            _focusNodes[index + 1].requestFocus();
          }
        },
      ),
    );
  }
}
