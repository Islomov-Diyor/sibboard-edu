import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sibboard_edu/app.dart';
import 'package:sibboard_edu/core/providers/app_providers.dart';
import 'package:sibboard_edu/data/local_store.dart';
import 'package:sibboard_edu/features/about/author_screen.dart';
import 'package:sibboard_edu/features/capabilities/capabilities_screen.dart';
import 'package:sibboard_edu/features/goals/goals_screen.dart';
import 'package:sibboard_edu/features/rules/rules_screen.dart';
import 'package:sibboard_edu/features/search/search_screen.dart';
import 'package:sibboard_edu/features/settings/settings_screen.dart';
import 'package:sibboard_edu/features/work/sibboard_3d_screen.dart';
import 'package:sibboard_edu/features/work/task_builder_screen.dart';
import 'package:sibboard_edu/features/work/work_screen.dart';
import 'package:sibboard_edu/l10n/app_localizations.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Phone Responsiveness & Anti-Overflow Tests', () {
    final phoneSizes = [
      const Size(320, 568), // Compact phone (iPhone SE 1st gen / ultra small Android)
      const Size(360, 640), // Standard budget Android phone
      const Size(390, 844), // Standard modern phone (iPhone 12/13/14)
    ];

    final scales = [1.0, 1.15, 1.3];

    for (final size in phoneSizes) {
      for (final scale in scales) {
        testWidgets(
            'App renders cleanly on ${size.width.toInt()}x${size.height.toInt()} with textScale $scale',
            (WidgetTester tester) async {
          tester.view.physicalSize = size;
          tester.view.devicePixelRatio = 1.0;
          addTearDown(tester.view.resetPhysicalSize);
          addTearDown(tester.view.resetDevicePixelRatio);

          SharedPreferences.setMockInitialValues({});
          final prefs = await SharedPreferences.getInstance();
          final localStore = LocalStore(prefs);
          await localStore.setTextScale(scale);

          await tester.pumpWidget(
            ProviderScope(
              overrides: [
                localStoreProvider.overrideWithValue(localStore),
              ],
              child: const SibboardEduApp(),
            ),
          );

          // Advance past splash screen and animations
          await tester.pump(const Duration(milliseconds: 500));
          await tester.pump(const Duration(milliseconds: 1000));
          await tester.pump(const Duration(milliseconds: 500));
          await tester.pump(const Duration(milliseconds: 500));

          // Verify no overflows occurred
          expect(tester.takeException(), isNull);

          // Verify navigation bar is visible and title is rendered
          expect(find.byType(NavigationBar), findsOneWidget);
          expect(find.text('SIBBOARD'), findsOneWidget);
          expect(find.text('EDU'), findsOneWidget);
        });
      }
    }

    testWidgets('AuthorScreen renders cleanly on 320x568 compact phone with scale 1.3',
        (WidgetTester tester) async {
      tester.view.physicalSize = const Size(320, 568);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();
      final localStore = LocalStore(prefs);
      await localStore.setTextScale(1.3);

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            localStoreProvider.overrideWithValue(localStore),
          ],
          child: const MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: AuthorScreen(),
          ),
        ),
      );

      await tester.pump(const Duration(milliseconds: 500));
      await tester.pump(const Duration(milliseconds: 500));
      expect(tester.takeException(), isNull);
      expect(find.byType(AuthorScreen), findsOneWidget);
    });

    testWidgets('GoalsScreen renders cleanly on 320x568 compact phone with scale 1.3',
        (WidgetTester tester) async {
      tester.view.physicalSize = const Size(320, 568);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();
      final localStore = LocalStore(prefs);
      await localStore.setTextScale(1.3);

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            localStoreProvider.overrideWithValue(localStore),
          ],
          child: const MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: Scaffold(body: GoalsScreen()),
          ),
        ),
      );

      await tester.pump(const Duration(milliseconds: 500));
      await tester.pump(const Duration(milliseconds: 500));
      expect(tester.takeException(), isNull);
      expect(find.byType(GoalsScreen), findsOneWidget);
    });

    testWidgets('CapabilitiesScreen renders cleanly on 320x568 compact phone with scale 1.3',
        (WidgetTester tester) async {
      tester.view.physicalSize = const Size(320, 568);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();
      final localStore = LocalStore(prefs);
      await localStore.setTextScale(1.3);

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            localStoreProvider.overrideWithValue(localStore),
          ],
          child: const MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: Scaffold(body: CapabilitiesScreen()),
          ),
        ),
      );

      await tester.pump(const Duration(milliseconds: 500));
      await tester.pump(const Duration(milliseconds: 500));
      expect(tester.takeException(), isNull);
      expect(find.byType(CapabilitiesScreen), findsOneWidget);
    });

    testWidgets('WorkScreen renders cleanly on 320x568 compact phone with scale 1.3',
        (WidgetTester tester) async {
      tester.view.physicalSize = const Size(320, 568);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();
      final localStore = LocalStore(prefs);
      await localStore.setTextScale(1.3);

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            localStoreProvider.overrideWithValue(localStore),
          ],
          child: const MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: Scaffold(body: WorkScreen()),
          ),
        ),
      );

      await tester.pump(const Duration(milliseconds: 500));
      await tester.pump(const Duration(milliseconds: 500));
      expect(tester.takeException(), isNull);
      expect(find.byType(WorkScreen), findsOneWidget);
    });

    testWidgets('RulesScreen renders cleanly on 320x568 compact phone with scale 1.3',
        (WidgetTester tester) async {
      tester.view.physicalSize = const Size(320, 568);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();
      final localStore = LocalStore(prefs);
      await localStore.setTextScale(1.3);

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            localStoreProvider.overrideWithValue(localStore),
          ],
          child: const MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: Scaffold(body: RulesScreen()),
          ),
        ),
      );

      await tester.pump(const Duration(milliseconds: 500));
      await tester.pump(const Duration(milliseconds: 500));
      expect(tester.takeException(), isNull);
      expect(find.byType(RulesScreen), findsOneWidget);
    });

    testWidgets('SearchScreen renders cleanly on 320x568 compact phone with scale 1.3',
        (WidgetTester tester) async {
      tester.view.physicalSize = const Size(320, 568);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();
      final localStore = LocalStore(prefs);
      await localStore.setTextScale(1.3);

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            localStoreProvider.overrideWithValue(localStore),
          ],
          child: const MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: SearchScreen(),
          ),
        ),
      );

      await tester.pump(const Duration(milliseconds: 500));
      await tester.pump(const Duration(milliseconds: 500));
      expect(tester.takeException(), isNull);
      expect(find.byType(SearchScreen), findsOneWidget);
    });

    testWidgets('TaskBuilderScreen renders cleanly on 320x568 compact phone with scale 1.3',
        (WidgetTester tester) async {
      tester.view.physicalSize = const Size(320, 568);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();
      final localStore = LocalStore(prefs);
      await localStore.setTextScale(1.3);

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            localStoreProvider.overrideWithValue(localStore),
          ],
          child: const MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: TaskBuilderScreen(),
          ),
        ),
      );

      await tester.pump(const Duration(milliseconds: 500));
      await tester.pump(const Duration(milliseconds: 500));
      expect(tester.takeException(), isNull);
      expect(find.byType(TaskBuilderScreen), findsOneWidget);
    });

    testWidgets('SettingsScreen renders cleanly on 320x568 compact phone with scale 1.3',
        (WidgetTester tester) async {
      tester.view.physicalSize = const Size(320, 568);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();
      final localStore = LocalStore(prefs);
      await localStore.setTextScale(1.3);

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            localStoreProvider.overrideWithValue(localStore),
          ],
          child: const MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: SettingsScreen(),
          ),
        ),
      );

      await tester.pump(const Duration(milliseconds: 500));
      await tester.pump(const Duration(milliseconds: 500));
      expect(tester.takeException(), isNull);
      expect(find.byType(SettingsScreen), findsOneWidget);
    });

    testWidgets('Sibboard3dScreen renders cleanly on 320x568 compact phone with scale 1.3',
        (WidgetTester tester) async {
      tester.view.physicalSize = const Size(320, 568);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();
      final localStore = LocalStore(prefs);
      await localStore.setTextScale(1.3);

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            localStoreProvider.overrideWithValue(localStore),
          ],
          child: const MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: Sibboard3dScreen(),
          ),
        ),
      );

      await tester.pump(const Duration(milliseconds: 500));
      await tester.pump(const Duration(milliseconds: 500));
      expect(tester.takeException(), isNull);
      expect(find.byType(Sibboard3dScreen), findsOneWidget);
    });
  });
}
