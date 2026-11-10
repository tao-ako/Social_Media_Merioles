import 'package:flutter/material.dart';

import '../model/userdata.dart';
import 'common.dart';

class FriendList extends StatelessWidget {
  const FriendList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SectionHeading(title: 'Friends', trailing: '6 Friends'),
        const SizedBox(height: 12),
        GridView.builder(
          itemCount: UserData.friends.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 1.08,
          ),
          itemBuilder: (context, index) {
            final friend = UserData.friends[index];
            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFECE8F1)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ProfileAvatar(image: friend.image, radius: 23),
                  const SizedBox(height: 7),
                  Text(
                    friend.name,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
