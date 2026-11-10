import 'package:flutter/material.dart';

import '../model/userpost.dart';
import 'common.dart';

class PostDetailsView extends StatelessWidget {
  const PostDetailsView({super.key, required this.post});

  final UserPost post;

  @override
  Widget build(BuildContext context) {
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
      body: ListView(
        children: [
          Image.asset(post.image, width: double.infinity, fit: BoxFit.contain),
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 18, 18, 10),
            child: Row(
              children: [
                ProfileAvatar(image: post.avatarImage),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        post.username,
                        style: const TextStyle(fontWeight: FontWeight.w800),
                      ),
                      Text(
                        post.time,
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
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Text(post.caption),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 18, 12, 14),
            child: PostActions(
              likes: post.likes,
              comments: post.comments.length,
              shares: post.shares,
            ),
          ),
          const Divider(height: 1, indent: 18, endIndent: 18),
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 18, 18, 8),
            child: Text(
              'All Comments',
              style: Theme.of(context).textTheme.titleMedium
                  ?.copyWith(fontWeight: FontWeight.w800),
            ),
          ),
          ...post.comments.map((comment) {
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
                                style: const TextStyle(
                                  fontWeight: FontWeight.w800,
                                ),
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
          }),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
