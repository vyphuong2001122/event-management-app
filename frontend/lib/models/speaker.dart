class Speaker {
  final String name;
  final String bio;
  final String profilePicture;

  Speaker({
    required this.name,
    required this.bio,
    required this.profilePicture,
  });

  factory Speaker.fromJson(Map<String, dynamic> json) {
    return Speaker(
      name: json['name'],
      profilePicture: json['profilePicture'],
      bio: json['bio'],
    );
  }
}
