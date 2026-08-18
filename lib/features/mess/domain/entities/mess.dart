import 'package:equatable/equatable.dart';

/// A single mess (shared household): created by its manager, joined by
/// members via [inviteCode].
class Mess extends Equatable {
  final String id;
  final String name;
  final String inviteCode;

  const Mess({required this.id, required this.name, required this.inviteCode});

  @override
  List<Object?> get props => [id, name, inviteCode];
}
