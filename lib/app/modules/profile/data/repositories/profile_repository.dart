import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:up_edema/app/modules/profile/domain/interfaces/IProfile_repository.dart';
import 'package:up_edema/app/modules/profile/domain/models/profile_data_model.dart';

class ProfileRepository implements IProfilerepository {
  final SupabaseClient _supabase;

  ProfileRepository(this._supabase);

  @override
  Future<ProfileDataModel> getCurrentUserProfile() async {
    final user = _supabase.auth.currentUser;
    if (user == null) {
      return const ProfileDataModel(
        email: '',
        phone: '',
        crm: '',
        dob: null,
        status: '',
      );
    }

    final profile = await _supabase
        .from('profiles')
        .select('*')
        .eq('id', user.id)
        .maybeSingle();

    final email = user.email ?? '';
    final phone = (profile?['phone'] as String?) ?? '';
    final crmRaw = profile?['crm'];
    final crm = crmRaw == null
        ? ''
        : (crmRaw is String ? crmRaw : crmRaw.toString());

    final dynamic dobRaw =
        profile?['birth_date'] ?? profile?['date_of_birth'] ?? profile?['dob'];
    DateTime? dob;
    if (dobRaw is String) {
      dob = DateTime.tryParse(dobRaw);
    } else if (dobRaw is DateTime) {
      dob = dobRaw;
    }

    final status = (profile?['status'] as String?) ?? '';

    return ProfileDataModel(
      email: email,
      phone: phone,
      crm: crm,
      dob: dob,
      status: status,
    );
  }
}