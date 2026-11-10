import 'package:flutter/material.dart';

String initialsForName(String name) => name
    .split(' ')
    .where((part) => part.isNotEmpty)
    .take(2)
    .map((part) => part[0])
    .join()
    .toUpperCase();

class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({
    super.key,
    this.initials,
    this.image,
    this.color = const Color(0xFFE5C4E8),
    this.radius = 22,
  });

  final String? initials;
  final String? image;
  final Color color;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: color,
      backgroundImage: image == null ? null : AssetImage(image!),
      child: image == null
          ? Text(
              initials ?? 'K',
              style: TextStyle(
                color: const Color(0xFF39354E),
                fontSize: radius * .62,
                fontWeight: FontWeight.w700,
              ),
            )
          : null,
    );
  }
}

class SectionHeading extends StatelessWidget {
  const SectionHeading({
    super.key,
    required this.title,
    required this.trailing,
  });

  final String title;
  final String trailing;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w800),
        ),
        const Spacer(),
        Text(
          trailing,
          style: const TextStyle(
            color: Color(0xFF777486),
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class PostActions extends StatelessWidget {
  const PostActions({
    super.key,
    required this.likes,
    required this.comments,
    required this.shares,
  });

  final int likes;
  final int comments;
  final int shares;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _Action(icon: Icons.favorite_border, label: '$likes'),
        _Action(icon: Icons.mode_comment_outlined, label: '$comments'),
        _Action(icon: Icons.ios_share_rounded, label: '$shares'),
      ],
    );
  }
}

class _Action extends StatelessWidget {
  const _Action({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 20, color: const Color(0xFF555267)),
        const SizedBox(width: 7),
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF555267),
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
