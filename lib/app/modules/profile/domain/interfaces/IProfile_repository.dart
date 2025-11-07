import 'package:up_edema/app/modules/profile/domain/models/profile_data_model.dart';

abstract interface class IProfilerepository {
  Future<ProfileDataModel> getCurrentUserProfile();
}