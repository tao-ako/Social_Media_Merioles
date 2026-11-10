import 'friend.dart';
import 'usercomment.dart';
import 'userpost.dart';

class UserData {
  static const fullName = 'Kevin Loyd T. Merioles';
  static const email = 'k.merioles.537327@umindanao.edu.ph';
  static const profileImage = 'assets/kevin.jpg';
  static const friends = [
    Friend(name: 'Alice', image: 'assets/alice.jpg'),
    Friend(name: 'Bob', image: 'assets/bob.jpg'),
    Friend(name: 'Charlie', image: 'assets/charlie.jpg'),
    Friend(name: 'David', image: 'assets/david.jpg'),
    Friend(name: 'Emily', image: 'assets/emily.jpg'),
    Friend(name: 'Sophia', image: 'assets/sophia.jpg'),
  ];

  static const _comments = [
    UserComment(
      name: 'Jane Smith',
      initials: 'JS',
      message: 'Looks fun!',
      time: '1 hour ago',
      color: 0xFFE8B4CA,
      image: 'assets/jane.jpg',
    ),
    UserComment(
      name: 'Mike Johnson',
      initials: 'MJ',
      message: 'Wish I was there!',
      time: '30 mins ago',
      color: 0xFFABC7E8,
      image: 'assets/mike.jpg',
    ),
    UserComment(
      name: 'Emily Rose',
      initials: 'ER',
      message: 'This looks amazing!',
      time: '15 mins ago',
      color: 0xFFD3B8E5,
      image: 'assets/emily.jpg',
    ),
  ];

  static const posts = [
    UserPost(
      id: 'john-beach',
      username: 'John Doe',
      time: '2 hours ago',
      caption: 'Had a great day at the beach!',
      image: 'assets/strawberry_pavlova.jpg',
      avatarImage: 'assets/john.jpg',
      likes: 128,
      shares: 12,
      comments: _comments,
    ),
    UserPost(
      id: 'alice-weekend',
      username: 'Alice Williams',
      time: 'Yesterday',
      caption: 'A little weekend adventure with my favorite people ✨',
      image: 'assets/day_out.webp',
      avatarImage: 'assets/alice.jpg',
      likes: 86,
      shares: 8,
      comments: _comments,
    ),
    UserPost(
      id: 'bob-moments',
      username: 'Bob Martin',
      time: '2 days ago',
      caption: 'Making the most of every moment.',
      image: 'assets/friends.webp',
      avatarImage: 'assets/bob.jpg',
      likes: 54,
      shares: 5,
      comments: _comments,
    ),
    UserPost(
      id: 'sophia-memories',
      username: 'Sophia Lee',
      time: '3 days ago',
      caption: 'Good vibes and even better memories 💜',
      image: 'assets/weekend.webp',
      avatarImage: 'assets/sophia.jpg',
      likes: 203,
      shares: 19,
      comments: _comments,
    ),
  ];
}
