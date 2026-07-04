import 'package:flutter_test/flutter_test.dart';

import 'package:my_first_app/main.dart';

void main() {
  testWidgets('StudyMate splash transitions into dashboard', (tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('StudyMate'), findsOneWidget);
    expect(find.text("Organize tasks easily"), findsOneWidget);

    await tester.pump(const Duration(milliseconds: 2500));
    await tester.pump(const Duration(milliseconds: 500));

    expect(find.text('Today'), findsWidgets);
    expect(find.text('My Tasks'), findsOneWidget);
    expect(find.text('Choose Activity'), findsOneWidget);
    expect(find.text('Finance'), findsOneWidget);
  });
}
