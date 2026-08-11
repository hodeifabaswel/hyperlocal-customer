import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hyperlocal_customer/app.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(child: HyperlocalCustomerApp()),
    );

    // Verifikasi app ter-render tanpa crash
    expect(find.byType(HyperlocalCustomerApp), findsOneWidget);
  });
}
