import 'package:flutter/material.dart';

class MainHeader extends StatelessWidget implements PreferredSizeWidget {
  const MainHeader({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(
        'TikTokTok',
        style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: -.5),
      ),
      actions: [
        IconButton(
          tooltip: 'Messages',
          onPressed: () {},
          icon: const Icon(Icons.chat_bubble_outline_rounded),
        ),
        const SizedBox(width: 6),
      ],
    );
  }
}
