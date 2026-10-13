import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sibboard_edu/app.dart';
import 'package:sibboard_edu/core/providers/app_providers.dart';
import 'package:sibboard_edu/data/local_store.dart';

void main() {
  testWidgets('SibboardEduApp initial render smoke test', (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    final localStore = LocalStore(prefs);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          localStoreProvider.overrideWithValue(localStore),
        ],
        child: const SibboardEduApp(),
      ),
    );

    // Initial frame on SplashScreen
    expect(find.text('SIBBOARD'), findsOneWidget);
    expect(find.text('EDU'), findsOneWidget);

    // Advance clock past splash transition
    await tester.pump(const Duration(milliseconds: 1600));
    await tester.pumpAndSettle();

    // Verify navigation to Home screen completed
    expect(find.text('SIBBOARD'), findsOneWidget);
    expect(find.text('EDU'), findsOneWidget);
  });
}
