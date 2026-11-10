import 'package:flutter/material.dart';

import '../model/userdata.dart';
import 'common.dart';

class InfoHeader extends StatelessWidget {
  const InfoHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        const ProfileAvatar(image: UserData.profileImage, radius: 48),
        const SizedBox(height: 14),
        const Text(
          UserData.fullName,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 5),
        const Text(
          UserData.email,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 12, color: Color(0xFF777486)),
        ),
        const SizedBox(height: 20),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _ProfileStat(value: '1 Million', label: 'Followers'),
            _ProfileStat(value: '500', label: 'Following'),
            _ProfileStat(value: '350', label: 'Posts'),
          ],
        ),
      ],
    );
  }
}

class _ProfileStat extends StatelessWidget {
  const _ProfileStat({required this.value, required this.label});

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value, style: const TextStyle(fontWeight: FontWeight.w800)),
        const SizedBox(height: 3),
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: Color(0xFF777486)),
        ),
      ],
    );
  }
}
