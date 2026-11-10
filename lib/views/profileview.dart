import 'package:flutter/material.dart';

import 'friendlist.dart';
import 'infoheader.dart';
import 'mainheader.dart';
import 'postlist.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  static const routeName = '/profile';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MainHeader(),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(18, 0, 18, 0),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                const InfoHeader(),
                const SizedBox(height: 26),
                const FriendList(),
                const SizedBox(height: 26),
              ]),
            ),
          ),
          const PostList(),
        ],
      ),
    );
  }
}
