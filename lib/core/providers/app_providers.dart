import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/content_repository.dart';
import '../../data/local_store.dart';
import '../../data/models/task_model.dart';

// Repositories
final localStoreProvider = Provider<LocalStore>((ref) {
  throw UnimplementedError('LocalStore must be initialized before use');
});

final contentRepositoryProvider = Provider<ContentRepository>((ref) {
  return ContentRepository();
});

// Locale State
class LocaleNotifier extends StateNotifier<String> {
  final LocalStore _store;

  LocaleNotifier(this._store) : super(_store.getLocale());

  Future<void> setLocale(String lang) async {
    if (lang != state) {
      state = lang;
      await _store.setLocale(lang);
    }
  }
}

final localeProvider = StateNotifierProvider<LocaleNotifier, String>((ref) {
  final store = ref.watch(localStoreProvider);
  return LocaleNotifier(store);
});

// Text Scale Factor
class TextScaleNotifier extends StateNotifier<double> {
  final LocalStore _store;

  TextScaleNotifier(this._store) : super(_store.getTextScale());

  Future<void> setScale(double scale) async {
    state = scale;
    await _store.setTextScale(scale);
  }
}

final textScaleProvider =
    StateNotifierProvider<TextScaleNotifier, double>((ref) {
  final store = ref.watch(localStoreProvider);
  return TextScaleNotifier(store);
});

// Favorites State
class FavoritesNotifier extends StateNotifier<Set<String>> {
  final LocalStore _store;

  FavoritesNotifier(this._store) : super(_store.getFavorites());

  Future<void> toggle(String id) async {
    await _store.toggleFavorite(id);
    state = _store.getFavorites();
  }

  Future<void> clearAll() async {
    await _store.clearFavorites();
    state = {};
  }
}

final favoritesProvider =
    StateNotifierProvider<FavoritesNotifier, Set<String>>((ref) {
  final store = ref.watch(localStoreProvider);
  return FavoritesNotifier(store);
});

// Read Sections State
class ReadSectionsNotifier extends StateNotifier<Set<String>> {
  final LocalStore _store;

  ReadSectionsNotifier(this._store) : super(_store.getReadSections());

  Future<void> markRead(String sectionId) async {
    await _store.markSectionRead(sectionId);
    state = _store.getReadSections();
  }

  Future<void> resetAll() async {
    await _store.clearReadSections();
    state = {};
  }
}

final readSectionsProvider =
    StateNotifierProvider<ReadSectionsNotifier, Set<String>>((ref) {
  final store = ref.watch(localStoreProvider);
  return ReadSectionsNotifier(store);
});

// User Tasks State
class UserTasksNotifier extends StateNotifier<List<UserTask>> {
  final LocalStore _store;

  UserTasksNotifier(this._store) : super(_store.getUserTasks());

  Future<void> save(UserTask task) async {
    await _store.saveUserTask(task);
    state = _store.getUserTasks();
  }

  Future<void> remove(String taskId) async {
    await _store.deleteUserTask(taskId);
    state = _store.getUserTasks();
  }
}

final userTasksProvider =
    StateNotifierProvider<UserTasksNotifier, List<UserTask>>((ref) {
  final store = ref.watch(localStoreProvider);
  return UserTasksNotifier(store);
});

// Safety Checklist State
class SafetyChecklistNotifier extends StateNotifier<Set<int>> {
  final LocalStore _store;

  SafetyChecklistNotifier(this._store) : super(_store.getSafetyChecklist());

  Future<void> toggle(int index) async {
    await _store.toggleSafetyItem(index);
    state = _store.getSafetyChecklist();
  }

  Future<void> clear() async {
    await _store.clearSafetyChecklist();
    state = {};
  }
}

final safetyChecklistProvider =
    StateNotifierProvider<SafetyChecklistNotifier, Set<int>>((ref) {
  final store = ref.watch(localStoreProvider);
  return SafetyChecklistNotifier(store);
});
