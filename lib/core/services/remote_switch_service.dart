import 'dart:convert';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';

class RemoteSwitchService {
  static const String switchUrl =
      'https://raw.githubusercontent.com/Islomov-Diyor/sibboard-edu/main/license/app_status.json';

  static const String keyIsLocked = 'pref_app_license_locked';
  static const String keyLockTitle = 'pref_app_lock_title';
  static const String keyLockMessage = 'pref_app_lock_message';
  static const String keyContactPhone = 'pref_app_contact_phone';
  static const String keyContactTg = 'pref_app_contact_tg';

  /// Check remote status from GitHub and update local preferences.
  static Future<bool> checkAndSyncStatus(SharedPreferences prefs) async {
    try {
      final client = HttpClient();
      client.connectionTimeout = const Duration(seconds: 4);
      final uri = Uri.parse('$switchUrl?t=${DateTime.now().millisecondsSinceEpoch}');
      final request = await client.getUrl(uri);
      final response = await request.close().timeout(const Duration(seconds: 4));

      if (response.statusCode == 200) {
        final body = await response.transform(utf8.decoder).join();
        final data = jsonDecode(body) as Map<String, dynamic>;

        final isActive = data['is_active'] as bool? ?? true;
        final isLocked = !isActive;

        await prefs.setBool(keyIsLocked, isLocked);
        if (data['lock_title_uz'] != null) {
          await prefs.setString(keyLockTitle, data['lock_title_uz'].toString());
        }
        if (data['lock_message_uz'] != null) {
          await prefs.setString(keyLockMessage, data['lock_message_uz'].toString());
        }
        if (data['contact_phone'] != null) {
          await prefs.setString(keyContactPhone, data['contact_phone'].toString());
        }
        if (data['contact_telegram'] != null) {
          await prefs.setString(keyContactTg, data['contact_telegram'].toString());
        }

        return isLocked;
      }
    } catch (_) {
      // Network unreachable or offline - fall back to local stored state
    }

    return prefs.getBool(keyIsLocked) ?? false;
  }

  /// Synchronous quick check from local store
  static bool isCurrentlyLocked(SharedPreferences prefs) {
    return prefs.getBool(keyIsLocked) ?? false;
  }
}
