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
/// shape the remote data source returns. `name`/`email` come from the
/// member's own account (Serverpod's profile) — a manager can't edit
/// those, only [paymentStatus]/[paymentDate] (see `UpdateMemberPayment`).
class Member extends Equatable {
  final String id;
  final String name;
  final String username;
  final String email;
  final String profileImage;
  final DateTime joiningDate;
  final MemberPaymentStatus paymentStatus;

  /// `null` until a manager records a payment — a member who has never
  /// paid has no payment date, unlike the mock era's always-present one.
  final DateTime? paymentDate;

  const Member({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.profileImage,
    required this.joiningDate,
    this.paymentStatus = MemberPaymentStatus.due,
    this.paymentDate,
  });

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
