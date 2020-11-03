import 'package:binder/binder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_state_five_ways/ui/pages/pages.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../wrapper.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(binderWrapper(BinderPage()));

    /// Enter some text into note [TextField] and trigger a frame.
    await tester.enterText(find.byType(TextField), 'Test note');
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('Test note'), findsOneWidget);

    /// Tap create note [FlatButton] and trigger a frame
    await tester.tap(find.byType(FlatButton));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('Note: Test note'), findsOneWidget);
  });
}

Widget binderWrapper(Widget child) => BinderScope(
      child: Wrapper(
        child: child,
      ),
    );
