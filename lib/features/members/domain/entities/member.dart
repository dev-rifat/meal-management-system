import 'package:equatable/equatable.dart';

/// Whether a member's dues are outstanding or settled.
enum MemberPaymentStatus {
  due,
  clear;

  String get label => switch (this) {
        MemberPaymentStatus.due => 'Due',
        MemberPaymentStatus.clear => 'Clear',
      };
}

/// Domain-level representation of a mess member, decoupled from whatever
/// shape a future remote/local data source happens to return.
///
/// Immutable by design — updates go through [copyWith] and flow back
/// through the `UpdateMember` use case rather than mutating fields in place.
class Member extends Equatable {
  final String id;
  final String name;
  final String username;
  final String email;
  final String profileImage;
  final DateTime joiningDate;
  final MemberPaymentStatus paymentStatus;
  final DateTime paymentDate;

  const Member({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.profileImage,
    required this.joiningDate,
    this.paymentStatus = MemberPaymentStatus.due,
    required this.paymentDate,
  });

  Member copyWith({
    String? name,
    String? username,
    String? email,
    String? profileImage,
    DateTime? joiningDate,
    MemberPaymentStatus? paymentStatus,
    DateTime? paymentDate,
  }) {
    return Member(
      id: id,
      name: name ?? this.name,
      username: username ?? this.username,
      email: email ?? this.email,
      profileImage: profileImage ?? this.profileImage,
      joiningDate: joiningDate ?? this.joiningDate,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      paymentDate: paymentDate ?? this.paymentDate,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        username,
        email,
        profileImage,
        joiningDate,
        paymentStatus,
        paymentDate,
      ];
}
