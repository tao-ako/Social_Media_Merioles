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
      body: ListView(
        padding: const EdgeInsets.fromLTRB(18, 0, 18, 24),
        children: const [
          InfoHeader(),
          SizedBox(height: 26),
          FriendList(),
          SizedBox(height: 26),
          PostList(),
        ],
      ),
    );
  }
}
