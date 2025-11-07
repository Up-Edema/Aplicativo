import 'package:flutter_triple/flutter_triple.dart';
import 'package:up_edema/app/modules/profile/domain/interfaces/IProfile_repository.dart';
import 'package:up_edema/app/modules/profile/domain/models/profile_data_model.dart';

class PersonalDataState {
  final String email;
  final String phone;
  final String crm;
  final DateTime? dob;
  final String dobDisplay;
  final String status;

  const PersonalDataState({
    required this.email,
    required this.phone,
    required this.crm,
    required this.dob,
    required this.dobDisplay,
    required this.status,
  });

  factory PersonalDataState.initial() => const PersonalDataState(
        email: '',
        phone: '',
        crm: '',
        dob: null,
        dobDisplay: '',
        status: '',
      );

  PersonalDataState copyWith({
    String? email,
    String? phone,
    String? crm,
    DateTime? dob,
    String? dobDisplay,
    String? status,
  }) => PersonalDataState(
        email: email ?? this.email,
        phone: phone ?? this.phone,
        crm: crm ?? this.crm,
        dob: dob ?? this.dob,
        dobDisplay: dobDisplay ?? this.dobDisplay,
        status: status ?? this.status,
      );
}

class PersonalDataStore extends Store<PersonalDataState> {
  final IProfilerepository _repository;

  PersonalDataStore(this._repository) : super(PersonalDataState.initial());

  Future<void> load() async {
    setLoading(true);
    try {
      final ProfileDataModel model = await _repository.getCurrentUserProfile();
      final state = _mapModelToState(model);
      update(state);
    } catch (e) {
      setError(e);
    } finally {
      setLoading(false);
    }
  }

  PersonalDataState _mapModelToState(ProfileDataModel model) {
    return PersonalDataState(
      email: model.email,
      phone: model.phone,
      crm: model.crm,
      dob: model.dob,
      dobDisplay: _formatDatePt(model.dob),
      status: model.status,
    );
  }

  String _formatDatePt(DateTime? date) {
    if (date == null) return '';
    const months = [
      'jan', 'fev', 'mar', 'abr', 'mai', 'jun',
      'jul', 'ago', 'set', 'out', 'nov', 'dez',
    ];
    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }
}