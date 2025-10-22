import 'package:flutter_triple/flutter_triple.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:up_edema/app/modules/auth/domain/exceptions/auth_exceptions.dart'
    hide AuthException;
import 'package:up_edema/app/modules/auth/domain/interfaces/IAuth_repository.dart';
import 'package:up_edema/app/modules/core/config/service_locator.dart';

class VerificationStore extends Store<bool> {
  final IAuthrepository _authRepository;
  final SupabaseClient _supabase = getIt<SupabaseClient>();

  VerificationStore(this._authRepository) : super(false);

  Future<void> requestCode({required String email}) async {
    await execute(() async {
      await _authRepository.requestEmailVerificationCode(email: email);
      return state;
    });
  }

  Future<void> verifyCode({required String email, required String code}) async {
    setLoading(true);
    try {
      final profile = await _supabase
          .from('profiles')
          .select('id')
          .eq('email', email)
          .maybeSingle();

      if (profile == null || profile['id'] == null) {
        throw GenericAuthException(
          'Usuário não encontrado para o e-mail informado.',
        );
      }

      final userId = profile['id'] as String;
      final nowIso = DateTime.now().toUtc().toIso8601String();

      final row = await _supabase
          .from('email_verification_codes')
          .select('id, expires_at')
          .eq('user_id', userId)
          .eq('code', code)
          .gt('expires_at', nowIso)
          .maybeSingle();

      if (row == null) {
        throw GenericAuthException('Código inválido ou expirado.');
      }

      await _supabase
          .from('email_verification_codes')
          .delete()
          .eq('user_id', userId);

      update(true);
    } on AuthException catch (e) {
      setError(GenericAuthException(e.message));
    } catch (e) {
      setError(e);
    } finally {
      setLoading(false);
    }
  }
}
