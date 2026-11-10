import 'usercomment.dart';

class UserPost {
  const UserPost({
    required this.id,
    required this.username,
    required this.time,
    required this.caption,
    required this.image,
    required this.avatarImage,
    required this.likes,
    required this.shares,
    required this.comments,
  });

  final String id;
  final String username;
  final String time;
  final String caption;
  final String image;
  final String avatarImage;
  final int likes;
  final int shares;
  final List<UserComment> comments;
}
