class UserComment {
  const UserComment({
    required this.name,
    required this.initials,
    required this.message,
    required this.time,
    required this.color,
    required this.image,
  });

  final String name;
  final String initials;
  final String message;
  final String time;
  final int color;
  final String image;

  Map<String, Object> toJson() => {
    'name': name,
    'initials': initials,
    'message': message,
    'time': time,
    'color': color,
    'image': image,
  };

  factory UserComment.fromJson(Map<String, dynamic> json) {
    return UserComment(
      name: json['name'] as String,
      initials: json['initials'] as String,
      message: json['message'] as String,
      time: json['time'] as String,
      color: json['color'] as int,
      image: json['image'] as String,
    );
  }
}
