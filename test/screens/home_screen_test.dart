import 'package:bindchat/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Home screen has a title that says BindChat',
      (WidgetTester tester) async {
    Widget testWidget = new MediaQuery(
        data: new MediaQueryData(),
        child: new MaterialApp(home: new HomeScreen()));

    await tester.pumpWidget(testWidget);

    expect(find.text('BindChat'), findsOneWidget);
  });
}
