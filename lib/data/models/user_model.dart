class UserModel {
  final String login;
  final int id;
  final String avatarUrl;
  final String? name;
  final String? bio;
  final String? location;
  final String? email;
  final int publicRepos;
  final int followers;
  final int following;
  final DateTime createdAt;

  UserModel({
    required this.login,
    required this.id,
    required this.avatarUrl,
    this.name,
    this.bio,
    this.location,
    this.email,
    required this.publicRepos,
    required this.followers,
    required this.following,
    required this.createdAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      login: json['login'] ?? '',
      id: json['id'] ?? 0,
      avatarUrl: json['avatar_url'] ?? '',
      name: json['name'],
      bio: json['bio'],
      location: json['location'],
      email: json['email'],
      publicRepos: json['public_repos'] ?? 0,
      followers: json['followers'] ?? 0,
      following: json['following'] ?? 0,
      createdAt: DateTime.parse(json['created_at'] ?? DateTime.now().toIso8601String()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'login': login,
      'id': id,
      'avatar_url': avatarUrl,
      'name': name,
      'bio': bio,
      'location': location,
      'email': email,
      'public_repos': publicRepos,
      'followers': followers,
      'following': following,
      'created_at': createdAt.toIso8601String(),
    };
  }
}