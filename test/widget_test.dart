import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutv/app.dart';

void main() {
  testWidgets('App boots and displays Flutv title', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: FlutvApp()));
    await tester.pumpAndSettle();

    expect(find.text('Flutv'), findsWidgets);
    expect(find.byType(NavigationBar), findsOneWidget);
  });
}
