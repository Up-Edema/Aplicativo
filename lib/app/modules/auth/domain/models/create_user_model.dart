class UserCreateRequest {
  late String mail;
  late String password;
  late String phone;

  UserCreateRequest({
    required this.mail,
    required this.password,
    required this.phone,
  });
}
