import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mass_management/core/error/failure.dart';
import 'package:mass_management/core/error/result.dart';
import 'package:mass_management/features/members/domain/entities/member.dart';
import 'package:mass_management/features/members/domain/repositories/members_repository.dart';
import 'package:mass_management/features/members/domain/usecases/delete_member.dart';
import 'package:mass_management/features/members/domain/usecases/get_members.dart';

class _MockMembersRepository extends Mock implements MembersRepository {}

void main() {
  late _MockMembersRepository repository;

  setUp(() {
    repository = _MockMembersRepository();
  });

  final member = Member(
    id: '1',
    name: 'John Doe',
    username: '@johnd',
    email: 'john.doe@example.com',
    profileImage: 'https://example.com/john.png',
    joiningDate: DateTime(2023, 4, 15),
    paymentStatus: MemberPaymentStatus.clear,
    paymentDate: DateTime(2025, 9, 30),
  );

  group('GetMembers', () {
    test('forwards the query to the repository and returns its members', () async {
      when(() => repository.getMembers(query: 'john'))
          .thenAnswer((_) async => ResultSuccess([member]));

      final result = await GetMembers(repository)(const GetMembersParams(query: 'john'));

      expect(result, isA<ResultSuccess<List<Member>>>());
      result.fold(
        (_) => fail('expected success'),
        (members) => expect(members, [member]),
      );
      verify(() => repository.getMembers(query: 'john')).called(1);
    });
  });

  group('DeleteMember', () {
    test('deletes by id and surfaces a NotFoundFailure for an unknown id', () async {
      when(() => repository.deleteMember('missing'))
          .thenAnswer((_) async => const ResultError(NotFoundFailure('no such member')));

      final result = await DeleteMember(repository)(const DeleteMemberParams('missing'));

      expect(result, isA<ResultError<void>>());
      result.fold(
        (failure) => expect(failure, isA<NotFoundFailure>()),
        (_) => fail('expected failure'),
      );
    });
  });
}
