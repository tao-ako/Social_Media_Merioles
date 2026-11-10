import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'usercomment.dart';
import 'userpost.dart';

class CommentStore extends ChangeNotifier {
  CommentStore(this._preferences);

  static const _storageKey = 'tiktoktok.comments.v1';
  static CommentStore? _instance;

  static CommentStore get instance {
    final store = _instance;
    if (store == null) {
      throw StateError('CommentStore.initialize() must run before the app.');
    }
    return store;
  }

  static Future<void> initialize() async {
    final preferences = await SharedPreferences.getInstance();
    final store = CommentStore(preferences);
    await store.load();
    _instance?.dispose();
    _instance = store;
  }

  final SharedPreferences _preferences;
  final Map<String, List<UserComment>> _commentsByPost = {};

  Future<void> load() async {
    final savedComments = _preferences.getString(_storageKey);
    if (savedComments == null) return;

    final decoded = jsonDecode(savedComments);
    if (decoded is! Map<String, dynamic>) {
      throw const FormatException(
        'Saved post comments have an invalid format.',
      );
    }

    _commentsByPost
      ..clear()
      ..addAll(
        decoded.map(
          (postId, comments) => MapEntry(
            postId,
            (comments as List<dynamic>)
                .map(
                  (comment) =>
                      UserComment.fromJson(comment as Map<String, dynamic>),
                )
                .toList(),
          ),
        ),
      );
  }

  List<UserComment> commentsFor(UserPost post) => [
    ...post.comments,
    ...?_commentsByPost[post.id],
  ];

  Future<void> addComment(UserPost post, UserComment comment) async {
    final savedForPost = _commentsByPost.putIfAbsent(post.id, () => []);
    savedForPost.add(comment);

    final encoded = jsonEncode(
      _commentsByPost.map(
        (postId, comments) =>
            MapEntry(postId, comments.map((item) => item.toJson()).toList()),
      ),
    );

    try {
      final saved = await _preferences.setString(_storageKey, encoded);
      if (!saved) {
        throw StateError('The comment could not be saved to this device.');
      }
    } catch (_) {
      savedForPost.removeLast();
      if (savedForPost.isEmpty) _commentsByPost.remove(post.id);
      rethrow;
    }

    notifyListeners();
  }
}
