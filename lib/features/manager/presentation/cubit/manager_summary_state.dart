import 'package:equatable/equatable.dart';
import 'package:mass_management/features/manager/domain/entities/expense_summary.dart';

enum ManagerSummaryStatus { initial, loading, loaded, error }

class ManagerSummaryState extends Equatable {
  final ManagerSummaryStatus status;
  final ExpenseSummary? summary;
  final String? errorMessage;

  const ManagerSummaryState({
    this.status = ManagerSummaryStatus.initial,
    this.summary,
    this.errorMessage,
  });

  ManagerSummaryState copyWith({
    ManagerSummaryStatus? status,
    ExpenseSummary? summary,
    String? errorMessage,
  }) {
    return ManagerSummaryState(
      status: status ?? this.status,
      summary: summary ?? this.summary,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, summary, errorMessage];
}
