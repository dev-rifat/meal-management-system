import 'package:equatable/equatable.dart';

/// Whether an [Expense] was a personal/market purchase or a shared household
/// bill split across members.
enum ExpenseType { market, share }

class Expense extends Equatable {
  final String id;
  final String title;
  final double amount;
  final ExpenseType type;
  final DateTime date;
  final String details;
  final String spentBy;

  /// Only set when [type] is [ExpenseType.share] (e.g. "WiFi", "Gas").
  final String? billType;

  const Expense({
    required this.id,
    required this.title,
    required this.amount,
    required this.type,
    required this.date,
    required this.details,
    required this.spentBy,
    this.billType,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        amount,
        type,
        date,
        details,
        spentBy,
        billType,
      ];
}
