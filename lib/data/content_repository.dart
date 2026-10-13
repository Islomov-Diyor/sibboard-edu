import 'dart:convert';
import 'package:flutter/services.dart';

class SearchResultItem {
  final String sectionId;
  final String sectionTitle;
  final String matchedTitle;
  final String snippet;
  final String routePath;

  const SearchResultItem({
    required this.sectionId,
    required this.sectionTitle,
    required this.matchedTitle,
    required this.snippet,
    required this.routePath,
  });
}

class ContentRepository {
  final Map<String, dynamic> _cache = {};

  Future<Map<String, dynamic>> _loadJson(String path) async {
    if (_cache.containsKey(path)) {
      return _cache[path] as Map<String, dynamic>;
    }
    final raw = await rootBundle.loadString(path);
    final data = jsonDecode(raw) as Map<String, dynamic>;
    _cache[path] = data;
    return data;
  }

  Future<Map<String, dynamic>> getHomeData(String lang) =>
      _loadJson('assets/content/$lang/home.json');

  Future<Map<String, dynamic>> getGoalsData(String lang) =>
      _loadJson('assets/content/$lang/goals.json');

  Future<Map<String, dynamic>> getCapabilitiesData(String lang) =>
      _loadJson('assets/content/$lang/capabilities.json');

  Future<Map<String, dynamic>> getWorkData(String lang) =>
      _loadJson('assets/content/$lang/work.json');

  Future<Map<String, dynamic>> getRulesData(String lang) =>
      _loadJson('assets/content/$lang/rules.json');

  Future<Map<String, dynamic>> getAuthorData(String lang) =>
      _loadJson('assets/content/$lang/author.json');

  Future<List<SearchResultItem>> search(String query, String lang) async {
    final clean = query.trim().toLowerCase();
    if (clean.isEmpty) return [];

    final results = <SearchResultItem>[];

    // 1. Home
    try {
      final home = await getHomeData(lang);
      final homeTitle = home['title'] as String? ?? 'Главная';
      final definition = home['definition'] as String? ?? '';
      if (homeTitle.toLowerCase().contains(clean) ||
          definition.toLowerCase().contains(clean)) {
        results.add(SearchResultItem(
          sectionId: 'home',
          sectionTitle: homeTitle,
          matchedTitle: homeTitle,
          snippet: _extractSnippet(definition, clean),
          routePath: '/home',
        ));
      }

      final accordions = (home['accordions'] as List<dynamic>?) ?? [];
      for (final acc in accordions) {
        final t = acc['title'] as String? ?? '';
        final c = acc['content'] as String? ?? '';
        if (t.toLowerCase().contains(clean) || c.toLowerCase().contains(clean)) {
          results.add(SearchResultItem(
            sectionId: 'home',
            sectionTitle: homeTitle,
            matchedTitle: t,
            snippet: _extractSnippet(c, clean),
            routePath: '/home',
          ));
        }
      }
    } catch (_) {}

    // 2. Goals
    try {
      final goals = await getGoalsData(lang);
      final goalsTitle = goals['title'] as String? ?? 'Цели и задачи';
      final mainGoalDesc =
          goals['main_goal']?['description'] as String? ?? '';
      if (goalsTitle.toLowerCase().contains(clean) ||
          mainGoalDesc.toLowerCase().contains(clean)) {
        results.add(SearchResultItem(
          sectionId: 'goals',
          sectionTitle: goalsTitle,
          matchedTitle: goals['main_goal']?['title'] as String? ?? goalsTitle,
          snippet: _extractSnippet(mainGoalDesc, clean),
          routePath: '/goals',
        ));
      }

      final kidsTasks = (goals['children_tasks'] as List<dynamic>?) ?? [];
      for (final t in kidsTasks) {
        final title = t['title'] as String? ?? '';
        final items = (t['items'] as List<dynamic>?)?.join(' ') ?? '';
        if (title.toLowerCase().contains(clean) ||
            items.toLowerCase().contains(clean)) {
          results.add(SearchResultItem(
            sectionId: 'goals',
            sectionTitle: goalsTitle,
            matchedTitle: title,
            snippet: _extractSnippet(items, clean),
            routePath: '/goals',
          ));
        }
      }
    } catch (_) {}

    // 3. Capabilities
    try {
      final cap = await getCapabilitiesData(lang);
      final capTitle = cap['title'] as String? ?? 'Педагогические возможности';
      final cards = (cap['cards'] as List<dynamic>?) ?? [];
      for (final c in cards) {
        final title = c['title'] as String? ?? '';
        final develops = c['develops'] as String? ?? '';
        final back = c['back'] as String? ?? '';
        if (title.toLowerCase().contains(clean) ||
            develops.toLowerCase().contains(clean) ||
            back.toLowerCase().contains(clean)) {
          results.add(SearchResultItem(
            sectionId: 'capabilities',
            sectionTitle: capTitle,
            matchedTitle: title,
            snippet: '$develops — $back',
            routePath: '/capabilities',
          ));
        }
      }
    } catch (_) {}

    // 4. Work
    try {
      final work = await getWorkData(lang);
      final workTitle = work['title'] as String? ?? 'Возможности работы';
      final topics = (work['topics'] as List<dynamic>?) ?? [];
      for (final top in topics) {
        final t = top['title'] as String? ?? '';
        final d = top['description'] as String? ?? '';
        if (t.toLowerCase().contains(clean) || d.toLowerCase().contains(clean)) {
          results.add(SearchResultItem(
            sectionId: 'work',
            sectionTitle: workTitle,
            matchedTitle: t,
            snippet: _extractSnippet(d, clean),
            routePath: '/work',
          ));
        }
      }
    } catch (_) {}

    // 5. Rules
    try {
      final rules = await getRulesData(lang);
      final rulesTitle = rules['title'] as String? ?? 'Правила пользования';
      final sections = (rules['sections'] as List<dynamic>?) ?? [];
      for (final sec in sections) {
        final t = sec['title'] as String? ?? '';
        final items = (sec['items'] as List<dynamic>?)?.join(' ') ?? '';
        if (t.toLowerCase().contains(clean) ||
            items.toLowerCase().contains(clean)) {
          results.add(SearchResultItem(
            sectionId: 'rules',
            sectionTitle: rulesTitle,
            matchedTitle: t,
            snippet: _extractSnippet(items, clean),
            routePath: '/rules',
          ));
        }
      }
    } catch (_) {}

    // 6. Author
    try {
      final author = await getAuthorData(lang);
      final authorTitle = author['title'] as String? ?? 'Сведения об авторе';
      final fullName = author['full_name'] as String? ?? '';
      final position = author['position'] as String? ?? '';
      final workplace = author['workplace'] as String? ?? '';
      final specialty = author['specialty_name'] as String? ?? '';
      final address = author['address'] as String? ?? '';
      final aboutProject = author['about_project'] as String? ?? '';
      final combined =
          '$fullName $position $workplace $specialty $address $aboutProject';
      if (combined.toLowerCase().contains(clean)) {
        results.add(SearchResultItem(
          sectionId: 'author',
          sectionTitle: authorTitle,
          matchedTitle: fullName,
          snippet: _extractSnippet(combined, clean),
          routePath: '/author',
        ));
      }
    } catch (_) {}

    return results;
  }

  String _extractSnippet(String text, String query) {
    final idx = text.toLowerCase().indexOf(query);
    if (idx == -1) {
      return text.length > 140 ? '${text.substring(0, 140)}...' : text;
    }
    final start = (idx - 40) < 0 ? 0 : (idx - 40);
    final end = (idx + query.length + 80) > text.length
        ? text.length
        : (idx + query.length + 80);
    final snippet = text.substring(start, end).replaceAll('\n', ' ');
    final prefix = start > 0 ? '...' : '';
    final suffix = end < text.length ? '...' : '';
    return '$prefix$snippet$suffix';
  }
}
