import 'package:equatable/equatable.dart';

/// A single balance card's worth of figures.
///
/// The mess-wide balance card, the personal balance card, and the wallet
/// screen's summary strip are all just different [BalanceSummary]
/// instances rendered by different widgets — there is no separate entity
/// per screen.
///
/// [balance] is an actual money amount (shown by the personal card and the
/// wallet screen); [mealRate] is a per-meal rate (shown by the mess-wide
/// card and the wallet screen). Either may be null when the widget
/// rendering this summary has no use for it.
class BalanceSummary extends Equatable {
  final String label;
  final double? balance;
  final double? mealRate;
  final double deposit;
  final double expense;

  const BalanceSummary({
    required this.label,
    this.balance,
    this.mealRate,
    required this.deposit,
    required this.expense,
  });

  @override
  List<Object?> get props => [label, balance, mealRate, deposit, expense];
}
