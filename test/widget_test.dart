import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_application_3/main.dart';

void main() {
  testWidgets('App builds and shows the user list', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Mis Usuarios'), findsOneWidget);

    expect(find.byType(ListView), findsOneWidget);

    expect(find.text('Leanne Graham'), findsOneWidget);
  });
}
