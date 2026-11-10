import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:tiktoktok/model/commentstore.dart';
import 'package:tiktoktok/model/usercomment.dart';
import 'package:tiktoktok/model/userdata.dart';
import 'package:tiktoktok/socialmedia.dart';

void main() {
  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await CommentStore.initialize();
  });

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
    expect(find.byKey(const ValueKey('friend-Alice')), findsOneWidget);

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

    await tester.enterText(
      find.byKey(const ValueKey('comment-input')),
      'Testing a saved comment',
    );
    await tester.tap(find.byKey(const ValueKey('submit-comment')));
    await tester.pumpAndSettle();
    expect(find.text('Testing a saved comment'), findsOneWidget);

    await tester.tap(find.byTooltip('Back'));
    await tester.pumpAndSettle();
    expect(
      find.descendant(of: firstPost, matching: find.text('4')),
      findsOneWidget,
    );
  });

  test('comments remain saved when the store is recreated', () async {
    final post = UserData.posts.first;
    await CommentStore.instance.addComment(
      post,
      const UserComment(
        name: UserData.fullName,
        initials: 'KM',
        message: 'Saved for later',
        time: 'Just now',
        color: 0xFFE5C4E8,
        image: UserData.profileImage,
      ),
    );

    final preferences = await SharedPreferences.getInstance();
    final reloadedStore = CommentStore(preferences);
    await reloadedStore.load();

    expect(
      reloadedStore.commentsFor(post).map((comment) => comment.message),
      contains('Saved for later'),
    );
  });
}
