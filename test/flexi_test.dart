import 'package:flexi/flexi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget createFlexiTestWidget({required Widget child}) {
    return MaterialApp(
      home: Scaffold(
        body: Flexi(
          child: child,
          onScaleStart: (_) {},
          onScaleUpdate: (_, __, ___) {},
          onScaleEnd: (_) {},
        ),
      ),
    );
  }

  testWidgets('Flexi widget initialization', (WidgetTester tester) async {
    await tester.pumpWidget(createFlexiTestWidget(child: Text('Flexi child')));
    expect(find.text('Flexi child'), findsOneWidget);
  });

  testWidgets('Double tap resets state', (WidgetTester tester) async {
    final Key flexiChildKey = UniqueKey();
    await tester.pumpWidget(
        createFlexiTestWidget(child: Text('Flexi child', key: flexiChildKey)));

    final Offset initialPosition = tester.getCenter(find.byKey(flexiChildKey));

    await tester.pumpAndSettle();
    await tester
        .tap(find.text('Flexi child')); // simulate tap to trigger translation
    await tester.pumpAndSettle();
    await tester
        .tap(find.text('Flexi child')); // simulate double tap to trigger reset
    await tester.pumpAndSettle();

    final Offset finalPosition = tester.getCenter(find.byKey(flexiChildKey));
    expect(initialPosition,
        finalPosition); // check if position was reset after double tap
  });

  // Add more test cases to cover your widget's specific behaviors
}
