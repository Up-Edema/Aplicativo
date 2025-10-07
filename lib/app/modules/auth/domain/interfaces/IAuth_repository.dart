import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:up_edema/app/modules/auth/domain/models/create_user_model.dart';

abstract interface class IAuthrepository {
  Future<User> signUp({
    required UserCreateRequest userRequestModel,
  });
}
