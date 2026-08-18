enum UserRole {
  manager,
  member;

  String get value => this == UserRole.manager ? 'manager' : 'member';

  static UserRole fromValue(String? value) =>
      value == 'manager' ? UserRole.manager : UserRole.member;
}
