enum UserStatus { active, inactive }

extension UserStatusExtension on UserStatus {
  bool get isActive => this == UserStatus.active;
  bool get isInactive => this == UserStatus.inactive;

  String get name {
    switch (this) {
      case UserStatus.active:
        return 'active';
      case UserStatus.inactive:
        return 'inactive';
    }
  }

  static UserStatus fromString(String value) {
    switch (value.toLowerCase()) {
      case 'active':
        return UserStatus.active;
      case 'inactive':
        return UserStatus.inactive;
      default:
        throw ArgumentError('Invalid UserStatus: $value');
    }
  }
}
