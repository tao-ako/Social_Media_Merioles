import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tiktoktok/socialmedia.dart';

void main() {
  testWidgets('login validates empty fields', (tester) async {
    await tester.pumpWidget(const TikTokTokApp());
    await tester.tap(find.text('LOGIN'));
    await tester.pumpAndSettle();

    expect(find.text('Please enter your username'), findsOneWidget);
    expect(find.text('Please enter your password'), findsOneWidget);
  });

  testWidgets('login opens profile and post details', (tester) async {
    await tester.pumpWidget(const TikTokTokApp());
    await tester.enterText(
      find.byKey(const ValueKey('username-field')),
      'kevin',
    );
    await tester.enterText(
      find.byKey(const ValueKey('password-field')),
      'secret',
    );
    await tester.tap(find.text('LOGIN'));
    await tester.pumpAndSettle();

    expect(find.text('Kevin Loyd T. Merioles'), findsOneWidget);
    expect(find.text('Friends'), findsOneWidget);
    expect(find.text('Alice'), findsOneWidget);

    await tester.scrollUntilVisible(
      find.text('Latest Posts'),
      400,
      scrollable: find.byType(Scrollable).first,
    );
    final firstPost = find.byKey(const ValueKey('post-card-John Doe'));
    await tester.ensureVisible(firstPost);
    await tester.pumpAndSettle();
    await tester.tap(firstPost);
    await tester.pumpAndSettle();

    expect(find.text('All Comments'), findsOneWidget);
    expect(find.text('Jane Smith'), findsOneWidget);
    expect(find.text('Looks fun!'), findsOneWidget);
  });
}
