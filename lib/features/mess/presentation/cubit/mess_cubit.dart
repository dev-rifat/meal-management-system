import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mass_management/features/mess/domain/usecases/create_mess.dart';
import 'package:mass_management/features/mess/domain/usecases/join_mess.dart';
import 'package:mass_management/features/mess/presentation/cubit/mess_state.dart';

/// Drives the post-signup "Create New Mess" / "Join a Mess" screen.
class MessCubit extends Cubit<MessState> {
  final CreateMess _createMess;
  final JoinMess _joinMess;

  MessCubit({required CreateMess createMess, required JoinMess joinMess})
      : _createMess = createMess,
        _joinMess = joinMess,
        super(const MessInitial());

  Future<void> createMess(String name) async {
    emit(const MessSubmitting());
    final result = await _createMess(CreateMessParams(name));
    result.fold(
      (failure) => emit(MessFailure(failure.message)),
      (mess) => emit(MessReady(mess)),
    );
  }

  Future<void> joinMess(String inviteCode) async {
    emit(const MessSubmitting());
    final result = await _joinMess(JoinMessParams(inviteCode));
    result.fold(
      (failure) => emit(MessFailure(failure.message)),
      (mess) => emit(MessReady(mess)),
    );
  }
}
