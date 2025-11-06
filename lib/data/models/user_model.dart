class UserModel {
  final String login;
  final int id;
  final String avatarUrl;
  final String? name;
  final String? bio;
  final String? blog;        // new
  final String? location;
  final String? email;
  final int? publicRepos;
  final int? followers;
  final int? following;
  final String? company;
  final int? publicGists;
  final DateTime createdAt;

  UserModel({
    required this.login,
    required this.id,
    required this.avatarUrl,
    this.name,
    this.bio,
    this.blog,                 // new
    this.location,
    this.email,
    this.publicRepos,
    this.followers,
    this.following,
    this.company,
    this.publicGists,
    required this.createdAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      login: json['login'] ?? '',
      id: json['id'] ?? 0,
      avatarUrl: json['avatar_url'] ?? '',
      name: json['name'],
      bio: json['bio'],
      blog: json['blog'],           // new
      location: json['location'],
      email: json['email'],
      publicRepos: json['public_repos'],
      followers: json['followers'],
      following: json['following'],
      company: json['company'],
      publicGists: json['public_gists'],
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
      'blog': blog,                   // new
      'location': location,
      'email': email,
      'public_repos': publicRepos,
      'followers': followers,
      'following': following,
      'company': company,
      'public_gists': publicGists,
      'created_at': createdAt.toIso8601String(),
    };
  }
}