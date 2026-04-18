import 'package:flutter_test/flutter_test.dart';
import 'package:grandwolf_apple/main.dart';

void main() {
  testWidgets('App renders title text', (WidgetTester tester) async {
    await tester.pumpWidget(const GrandWolfApp());

    expect(find.text('Grand Wolf Flutter App'), findsOneWidget);
  });
}
