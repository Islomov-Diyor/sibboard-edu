import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'core/utils/page_transitions.dart';
import 'features/about/author_screen.dart';
import 'features/capabilities/capabilities_screen.dart';
import 'features/favorites/favorites_screen.dart';
import 'features/goals/goals_screen.dart';
import 'features/home/home_screen.dart';
import 'features/license/license_lock_screen.dart';
import 'features/rules/rules_screen.dart';
import 'features/search/search_screen.dart';
import 'features/settings/settings_screen.dart';
import 'features/shell/main_shell.dart';
import 'features/splash/splash_screen.dart';
import 'features/work/sibboard_3d_screen.dart';
import 'features/work/task_builder_screen.dart';
import 'features/work/work_screen.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'shell');

final GoRouter appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/splash',
  routes: [
    GoRoute(
      path: '/splash',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/lock',
      builder: (context, state) => const LicenseLockScreen(),
    ),
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) => MainShell(child: child),
      routes: [
        GoRoute(
          path: '/home',
          pageBuilder: (context, state) => buildFadeSlidePage(
            key: state.pageKey,
            child: const HomeScreen(),
          ),
        ),
        GoRoute(
          path: '/goals',
          pageBuilder: (context, state) => buildFadeSlidePage(
            key: state.pageKey,
            child: const GoalsScreen(),
          ),
        ),
        GoRoute(
          path: '/capabilities',
          pageBuilder: (context, state) => buildFadeSlidePage(
            key: state.pageKey,
            child: const CapabilitiesScreen(),
          ),
        ),
        GoRoute(
          path: '/work',
          pageBuilder: (context, state) => buildFadeSlidePage(
            key: state.pageKey,
            child: const WorkScreen(),
          ),
        ),
        GoRoute(
          path: '/rules',
          pageBuilder: (context, state) => buildFadeSlidePage(
            key: state.pageKey,
            child: const RulesScreen(),
          ),
        ),
      ],
    ),
    GoRoute(
      path: '/search',
      parentNavigatorKey: _rootNavigatorKey,
      pageBuilder: (context, state) => buildFadeSlidePage(
        key: state.pageKey,
        child: const SearchScreen(),
      ),
    ),
    GoRoute(
      path: '/favorites',
      parentNavigatorKey: _rootNavigatorKey,
      pageBuilder: (context, state) => buildFadeSlidePage(
        key: state.pageKey,
        child: const FavoritesScreen(),
      ),
    ),
    GoRoute(
      path: '/settings',
      parentNavigatorKey: _rootNavigatorKey,
      pageBuilder: (context, state) => buildFadeSlidePage(
        key: state.pageKey,
        child: const SettingsScreen(),
      ),
    ),
    GoRoute(
      path: '/work/task-builder',
      parentNavigatorKey: _rootNavigatorKey,
      pageBuilder: (context, state) => buildFadeSlidePage(
        key: state.pageKey,
        child: const TaskBuilderScreen(),
      ),
    ),
    GoRoute(
      path: '/author',
      parentNavigatorKey: _rootNavigatorKey,
      pageBuilder: (context, state) => buildFadeSlidePage(
        key: state.pageKey,
        child: const AuthorScreen(),
      ),
    ),
    GoRoute(
      path: '/sibboard-3d',
      parentNavigatorKey: _rootNavigatorKey,
      pageBuilder: (context, state) => buildFadeSlidePage(
        key: state.pageKey,
        child: const Sibboard3dScreen(),
      ),
    ),
  ],
);
