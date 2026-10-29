import 'package:flutter_test/flutter_test.dart';

import 'package:first_flutter_app/main.dart';

void main() {
  testWidgets('Student profile displays the supplied details', (WidgetTester tester) async {
    await tester.pumpWidget(const StudentInfoApp());

    expect(find.text('YAP CHI SHIEN'), findsOneWidget);
    expect(find.text('Student ID: BCS24090002'), findsOneWidget);
    expect(find.text('"Patient is key in life"'), findsOneWidget);
  });
}


