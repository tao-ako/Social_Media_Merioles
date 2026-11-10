import 'package:flutter/material.dart';

import '../model/commentstore.dart';
import '../model/userdata.dart';
import '../model/userpost.dart';
import 'common.dart';
import 'postdetailsview.dart';

class PostList extends StatelessWidget {
  const PostList({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.fromLTRB(18, 0, 18, 24),
      sliver: SliverList.builder(
        itemCount: UserData.posts.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return const Padding(
              padding: EdgeInsets.only(bottom: 12),
              child: SectionHeading(title: 'Latest Posts', trailing: 'See all'),
            );
          }
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: _PostCard(post: UserData.posts[index - 1]),
          );
        },
      ),
    );
  }
}

class _PostCard extends StatelessWidget {
  const _PostCard({required this.post});

  final UserPost post;

  @override
  Widget build(BuildContext context) {
    return Material(
      key: ValueKey('post-card-${post.username}'),
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute<void>(builder: (_) => PostDetailsView(post: post)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 14, 14, 12),
              child: Row(
                children: [
                  ProfileAvatar(image: post.avatarImage, radius: 21),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          post.username,
                          style: const TextStyle(fontWeight: FontWeight.w800),
                        ),
                        const SizedBox(height: 2),
                        Row(
                          children: [
                            Text(
                              post.time,
                              style: const TextStyle(
                                color: Color(0xFF858193),
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(width: 5),
                            const Icon(
                              Icons.public_rounded,
                              size: 13,
                              color: Color(0xFF858193),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const Icon(Icons.more_horiz, color: Color(0xFF777486)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Text(post.caption),
            ),
            const SizedBox(height: 12),
            AspectRatio(
              aspectRatio: 1.18,
              child: Image.asset(post.image, fit: BoxFit.cover),
            ),
            ListenableBuilder(
              listenable: CommentStore.instance,
              builder: (context, _) => Padding(
                padding: const EdgeInsets.fromLTRB(8, 12, 8, 12),
                child: PostActions(
                  likes: post.likes,
                  comments: CommentStore.instance.commentsFor(post).length,
                  shares: post.shares,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
