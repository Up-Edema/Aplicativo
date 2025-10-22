import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:up_edema/app/modules/auth/domain/models/create_user_model.dart';
import 'package:up_edema/app/modules/auth/domain/models/user_login_model.dart';

abstract interface class IAuthrepository {
  Future<void> signUp({
    required UserCreateRequest userRequestModel,
  });

  Future<User> login({
    required UserLoginModel loginModel,
  });

  Future<bool> isLoggedIn();

  Future<void> requestEmailVerificationCode({required String email});
}
