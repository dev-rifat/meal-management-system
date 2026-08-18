import 'dart:math';

import 'package:mass_management/core/error/exceptions.dart';
import 'package:mass_management/features/mess/domain/entities/mess.dart';

/// Purely in-memory mess store — matches the auth/members features' local
/// data sources; there is no backend yet, so every created mess and its
/// invite code is lost on app restart.
abstract class MessLocalDataSource {
  Mess createMess({required String name});

  Mess joinMess({required String inviteCode});
}

class MessLocalDataSourceImpl implements MessLocalDataSource {
  // Excludes visually-ambiguous characters (0/O, 1/I) since this code gets
  // read aloud and typed by hand.
  static const _codeChars = 'ABCDEFGHJKLMNPQRSTUVWXYZ23456789';

  final Map<String, Mess> _messesByCode = {};
  final Random _random = Random();
  int _nextId = 1;

  String _generateInviteCode() {
    String code;
    do {
      code = List.generate(
        6,
        (_) => _codeChars[_random.nextInt(_codeChars.length)],
      ).join();
    } while (_messesByCode.containsKey(code));
    return code;
  }

  @override
  Mess createMess({required String name}) {
    final mess = Mess(
      id: 'mess-${_nextId++}',
      name: name,
      inviteCode: _generateInviteCode(),
    );
    _messesByCode[mess.inviteCode] = mess;
    return mess;
  }

  @override
  Mess joinMess({required String inviteCode}) {
    final mess = _messesByCode[inviteCode.trim().toUpperCase()];
    if (mess == null) {
      throw const NotFoundException('No mess found for this invite code.');
    }
    return mess;
  }
}
