import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('example', (final tester) async {
    await tester.pumpWidget(const MaterialApp(home: Text('Hello World!')));

    expect(find.text('Hello World!'), findsOneWidget);
  });
}
