class Speaker {
  final int id;
  final String name;
  final String bio;
  final String profilePicture;

  Speaker({
    required this.id,
    required this.name,
    required this.bio,
    required this.profilePicture,
  });

  factory Speaker.fromJson(Map<String, dynamic> json) {
    return Speaker(
      id: json['id'] ?? 0,
      name: json['name'],
      profilePicture: json['profilePicture'],
      bio: json['bio'],
    );
  }
}
