enum UserRole {
  manager,
  member;

  String get value => this == UserRole.manager ? 'manager' : 'member';

  /// Any unrecognized or null [value] falls back to [UserRole.member] — the
  /// safer of the two roles to default an unknown account to.
  static UserRole fromValue(String? value) =>
      value == 'manager' ? UserRole.manager : UserRole.member;
}
