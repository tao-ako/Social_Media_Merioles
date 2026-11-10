import 'package:flutter/material.dart';

import '../model/commentstore.dart';
import '../model/usercomment.dart';
import '../model/userdata.dart';
import '../model/userpost.dart';
import 'common.dart';

class PostDetailsView extends StatefulWidget {
  const PostDetailsView({super.key, required this.post});

  final UserPost post;

  @override
  State<PostDetailsView> createState() => _PostDetailsViewState();
}

class _PostDetailsViewState extends State<PostDetailsView> {
  final _commentController = TextEditingController();
  final _scrollController = ScrollController();
  bool _isSaving = false;

  @override
  void dispose() {
    _commentController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _submitComment() async {
    final message = _commentController.text.trim();
    if (message.isEmpty || _isSaving) return;

    setState(() => _isSaving = true);
    final comment = UserComment(
      name: UserData.fullName,
      initials: initialsForName(UserData.fullName),
      message: message,
      time: 'Just now',
      color: 0xFFE5C4E8,
      image: UserData.profileImage,
    );

    try {
      await CommentStore.instance.addComment(widget.post, comment);
      if (!mounted) return;
      _commentController.clear();
      FocusScope.of(context).unfocus();
      await WidgetsBinding.instance.endOfFrame;
      if (_scrollController.hasClients) {
        await _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
        );
      }
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not save your comment: $error')),
        );
      }
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final store = CommentStore.instance;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          tooltip: 'Back',
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back_rounded),
        ),
        title: const Text(
          'Post',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
      ),
      body: ListenableBuilder(
        listenable: store,
        builder: (context, _) {
          final comments = store.commentsFor(widget.post);
          return ListView.builder(
            key: const ValueKey('post-details-list'),
            controller: _scrollController,
            itemCount: comments.length + 5,
            itemBuilder: (context, index) {
              if (index == 0) {
                return Image.asset(
                  widget.post.image,
                  width: double.infinity,
                  fit: BoxFit.contain,
                );
              }
              if (index == 1) return _postAuthor();
              if (index == 2) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Text(widget.post.caption),
                );
              }
              if (index == 3) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(12, 18, 12, 14),
                  child: PostActions(
                    likes: widget.post.likes,
                    comments: comments.length,
                    shares: widget.post.shares,
                  ),
                );
              }
              if (index == 4) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(18, 18, 18, 8),
                  child: Text(
                    'All Comments',
                    style: Theme.of(context).textTheme.titleMedium
                        ?.copyWith(fontWeight: FontWeight.w800),
                  ),
                );
              }
              return _CommentTile(comment: comments[index - 5]);
            },
          );
        },
      ),
      bottomNavigationBar: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(14, 8, 14, 8),
          child: Row(
            children: [
              const ProfileAvatar(image: UserData.profileImage, radius: 19),
              const SizedBox(width: 10),
              Expanded(
                child: TextField(
                  key: const ValueKey('comment-input'),
                  controller: _commentController,
                  textCapitalization: TextCapitalization.sentences,
                  textInputAction: TextInputAction.send,
                  onSubmitted: (_) => _submitComment(),
                  decoration: const InputDecoration(
                    hintText: 'Write a comment...',
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 4),
              IconButton(
                key: const ValueKey('submit-comment'),
                tooltip: 'Post comment',
                onPressed: _isSaving ? null : _submitComment,
                icon: _isSaving
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.send_rounded),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _postAuthor() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 10),
      child: Row(
        children: [
          ProfileAvatar(image: widget.post.avatarImage),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.post.username,
                  style: const TextStyle(fontWeight: FontWeight.w800),
                ),
                Text(
                  widget.post.time,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF858193),
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.public_rounded, color: Color(0xFF858193)),
        ],
      ),
    );
  }
}

class _CommentTile extends StatelessWidget {
  const _CommentTile({required this.comment});

  final UserComment comment;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 10, 18, 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProfileAvatar(
            initials: comment.initials,
            image: comment.image,
            color: Color(comment.color),
            radius: 20,
          ),
          const SizedBox(width: 11),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        comment.name,
                        style: const TextStyle(fontWeight: FontWeight.w800),
                      ),
                      const SizedBox(height: 4),
                      Text(comment.message),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, top: 6),
                  child: Row(
                    children: [
                      Text(
                        comment.time,
                        style: const TextStyle(
                          fontSize: 11,
                          color: Color(0xFF858193),
                        ),
                      ),
                      const SizedBox(width: 14),
                      const Text(
                        'Like',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF686477),
                        ),
                      ),
                      const SizedBox(width: 14),
                      const Text(
                        'Reply',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF686477),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
