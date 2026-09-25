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

  Future<void> createMess(String name, String phone) async {
    emit(const MessSubmitting());
    final result = await _createMess(
      CreateMessParams(name: name, phone: phone),
    );
    result.fold(
      (failure) => emit(MessFailure(failure.message)),
      (mess) => emit(MessReady(mess)),
    );
  }

  Future<void> joinMess(String inviteCode, String phone) async {
    emit(const MessSubmitting());
    final result = await _joinMess(
      JoinMessParams(inviteCode: inviteCode, phone: phone),
    );
    result.fold(
      (failure) => emit(MessFailure(failure.message)),
      (mess) => emit(MessReady(mess)),
    );
  }
}
