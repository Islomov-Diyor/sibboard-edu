import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'models/task_model.dart';

class LocalStore {
  static const String _keyLocale = 'app_locale';
  static const String _keyTextScale = 'text_scale';
  static const String _keyFavorites = 'favorites_items';
  static const String _keyReadSections = 'read_sections';
  static const String _keyTasks = 'user_created_tasks';
  static const String _keySafetyChecklist = 'safety_checklist';

  final SharedPreferences _prefs;

  LocalStore(this._prefs);

  // Locale
  String getLocale() => _prefs.getString(_keyLocale) ?? 'ru';
  Future<bool> setLocale(String lang) => _prefs.setString(_keyLocale, lang);

  // Text scale factor
  double getTextScale() => _prefs.getDouble(_keyTextScale) ?? 1.0;
  Future<bool> setTextScale(double scale) => _prefs.setDouble(_keyTextScale, scale);

  // Favorites
  Set<String> getFavorites() {
    final list = _prefs.getStringList(_keyFavorites) ?? [];
    return list.toSet();
  }

  Future<bool> toggleFavorite(String id) {
    final current = getFavorites();
    if (current.contains(id)) {
      current.remove(id);
    } else {
      current.add(id);
    }
    return _prefs.setStringList(_keyFavorites, current.toList());
  }

  Future<bool> clearFavorites() => _prefs.remove(_keyFavorites);

  // Read sections
  Set<String> getReadSections() {
    final list = _prefs.getStringList(_keyReadSections) ?? [];
    return list.toSet();
  }

  Future<bool> markSectionRead(String sectionId) {
    final current = getReadSections();
    current.add(sectionId);
    return _prefs.setStringList(_keyReadSections, current.toList());
  }

  Future<bool> clearReadSections() => _prefs.remove(_keyReadSections);

  // User tasks
  List<UserTask> getUserTasks() {
    final raw = _prefs.getStringList(_keyTasks) ?? [];
    return raw.map((jsonStr) {
      try {
        final map = jsonDecode(jsonStr) as Map<String, dynamic>;
        return UserTask.fromJson(map);
      } catch (_) {
        return null;
      }
    }).whereType<UserTask>().toList();
  }

  Future<bool> saveUserTask(UserTask task) {
    final tasks = getUserTasks();
    tasks.removeWhere((t) => t.id == task.id);
    tasks.insert(0, task);
    final raw = tasks.map((t) => jsonEncode(t.toJson())).toList();
    return _prefs.setStringList(_keyTasks, raw);
  }

  Future<bool> deleteUserTask(String taskId) {
    final tasks = getUserTasks();
    tasks.removeWhere((t) => t.id == taskId);
    final raw = tasks.map((t) => jsonEncode(t.toJson())).toList();
    return _prefs.setStringList(_keyTasks, raw);
  }

  // Safety checklist
  Set<int> getSafetyChecklist() {
    final list = _prefs.getStringList(_keySafetyChecklist) ?? [];
    return list.map((e) => int.tryParse(e)).whereType<int>().toSet();
  }

  Future<bool> toggleSafetyItem(int index) {
    final current = getSafetyChecklist();
    if (current.contains(index)) {
      current.remove(index);
    } else {
      current.add(index);
    }
    return _prefs.setStringList(
      _keySafetyChecklist,
      current.map((e) => e.toString()).toList(),
    );
  }

  Future<bool> clearSafetyChecklist() => _prefs.remove(_keySafetyChecklist);
}
