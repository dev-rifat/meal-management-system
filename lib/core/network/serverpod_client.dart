import 'package:mess_manager_server_client/mess_manager_server_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// The Serverpod dev server's address.
///
/// `localhost` works for iOS simulators and desktop, but NOT the Android
/// emulator, which needs `10.0.2.2` to reach the host machine — switch this
/// (or make it a build-time flag) if you're running on Android. A real
/// device needs the dev machine's LAN IP instead, and a real deployment
/// needs the deployed server's URL.
const String serverpodUrl = 'http://localhost:8080/';

/// Persists the session token to disk so a login survives an app restart —
/// previously (mock backend) sessions were lost every time. Also caches it
/// in memory so every request doesn't hit [SharedPreferences].
class PersistentAuthKeyManager implements AuthenticationKeyManager {
  static const _prefsKey = 'serverpod_auth_token';
  String? _cached;

  @override
  Future<String?> get() async {
    final cached = _cached;
    if (cached != null) return cached;
    final prefs = await SharedPreferences.getInstance();
    return _cached = prefs.getString(_prefsKey);
  }

  @override
  Future<void> put(String key) async {
    _cached = key;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_prefsKey, key);
  }

  @override
  Future<void> remove() async {
    _cached = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_prefsKey);
  }

  @override
  Future<String?> get authHeaderValue => getHeaderValue();

  @override
  Future<String?> getHeaderValue() async => toHeaderValue(await get());

  @override
  Future<String?> toHeaderValue(String? key) async =>
      key == null ? null : 'Bearer $key';
}
