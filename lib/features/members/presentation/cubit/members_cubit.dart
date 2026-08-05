import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mass_management/features/members/domain/entities/member.dart';
import 'package:mass_management/features/members/domain/usecases/delete_member.dart';
import 'package:mass_management/features/members/domain/usecases/get_members.dart';
import 'package:mass_management/features/members/domain/usecases/update_member.dart';
import 'package:mass_management/features/members/presentation/cubit/members_state.dart';

/// Drives the member list screen. Search-as-you-type, delete and update all
/// flow through the injected use cases (-> repository -> data source)
/// instead of mutating any captured list/entity directly.
class MembersCubit extends Cubit<MembersState> {
  final GetMembers _getMembers;
  final DeleteMember _deleteMember;
  final UpdateMember _updateMember;

  /// The most recent search query, so delete/update can refresh the list
  /// under the same filter afterwards.
  String _query = '';

  MembersCubit({
    required GetMembers getMembers,
    required DeleteMember deleteMember,
    required UpdateMember updateMember,
  })  : _getMembers = getMembers,
        _deleteMember = deleteMember,
        _updateMember = updateMember,
        super(const MembersLoading()) {
    search('');
  }

  /// Loads members matching [query]; an empty query returns everyone. Used
  /// both for the initial load and for search-as-you-type.
  Future<void> search(String query) async {
    _query = query;
    final result = await _getMembers(GetMembersParams(query: query));
    result.fold(
      (failure) => emit(MembersError(failure.message)),
      (members) => emit(MembersLoaded(members, query: query)),
    );
  }

  Future<void> delete(String id) async {
    final result = await _deleteMember(DeleteMemberParams(id));
    await result.fold(
      (failure) async => emit(MembersError(failure.message)),
      (_) async => search(_query),
    );
  }

  Future<void> update(Member member) async {
    final result = await _updateMember(UpdateMemberParams(member));
    await result.fold(
      (failure) async => emit(MembersError(failure.message)),
      (_) async => search(_query),
    );
  }
}
