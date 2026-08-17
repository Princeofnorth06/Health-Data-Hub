import 'package:flutter_test/flutter_test.dart';
import 'package:health_data_hub/main.dart';

void main() {
  testWidgets('App initializes', (WidgetTester tester) async {
    await tester.pumpWidget(const HealthDataHubApp());
    expect(find.byType(HealthDataHubApp), findsOneWidget);
  });
}
