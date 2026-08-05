import 'package:mass_management/core/error/exceptions.dart';
import 'package:mass_management/features/members/domain/entities/member.dart';

/// Purely in-memory member store. There is no backend for members yet, so
/// this is seeded with the same demo members the old single-file page used
/// to hardcode, and everything is lost on app restart — an accepted
/// limitation for this pass, matching the auth feature's local data source.
abstract class MembersLocalDataSource {
  List<Member> getMembers({String query = ''});

  void deleteMember(String id);

  Member updateMember(Member member);
}

class MembersLocalDataSourceImpl implements MembersLocalDataSource {
  final List<Member> _members = [
    Member(
      id: '1',
      name: 'John Doe',
      username: '@johnd',
      email: 'john.doe@example.com',
      profileImage: 'https://i.pravatar.cc/150?img=1',
      joiningDate: DateTime(2023, 4, 15),
      paymentStatus: MemberPaymentStatus.clear,
      paymentDate: DateTime(2025, 9, 30),
    ),
    Member(
      id: '2',
      name: 'Jane Smith',
      username: '@janes',
      email: 'jane.smith@example.com',
      profileImage: 'https://i.pravatar.cc/150?img=2',
      joiningDate: DateTime(2022, 12, 5),
      paymentStatus: MemberPaymentStatus.due,
      paymentDate: DateTime(2025, 10, 5),
    ),
  ];

  @override
  List<Member> getMembers({String query = ''}) {
    if (query.isEmpty) return List.unmodifiable(_members);

    final lowerQuery = query.toLowerCase();
    return _members.where((member) {
      final nameMatch = member.name.toLowerCase().contains(lowerQuery);
      final usernameMatch = member.username.toLowerCase().contains(lowerQuery);
      final emailMatch = member.email.toLowerCase().contains(lowerQuery);
      return nameMatch || usernameMatch || emailMatch;
    }).toList();
  }

  @override
  void deleteMember(String id) {
    final index = _members.indexWhere((member) => member.id == id);
    if (index == -1) {
      throw const NotFoundException('Member not found.');
    }
    _members.removeAt(index);
  }

  @override
  Member updateMember(Member member) {
    final index = _members.indexWhere((existing) => existing.id == member.id);
    if (index == -1) {
      throw const NotFoundException('Member not found.');
    }
    _members[index] = member;
    return member;
  }
}
