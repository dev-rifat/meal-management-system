import 'package:equatable/equatable.dart';

/// A single wallet/dashboard transaction line item. Shared by the
/// dashboard's "Transaction History" section and the wallet screen's "My
/// Transactions" section.
class Transaction extends Equatable {
  final String title;
  final DateTime date;
  final double amount;

  const Transaction({
    required this.title,
    required this.date,
    required this.amount,
  });

  @override
  List<Object?> get props => [title, date, amount];
}
