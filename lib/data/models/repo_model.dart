class RepoModel {
  final int id;
  final String name;
  final String fullName;
  final String? description;
  final bool private;
  final String htmlUrl;
  final int stargazersCount;
  final int watchersCount;
  final int forksCount;
  final String? language;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int openIssuesCount;
  final String? defaultBranch;

  RepoModel({
    required this.id,
    required this.name,
    required this.fullName,
    this.description,
    required this.private,
    required this.htmlUrl,
    required this.stargazersCount,
    required this.watchersCount,
    required this.forksCount,
    this.language,
    required this.createdAt,
    required this.updatedAt,
    required this.openIssuesCount,
    this.defaultBranch,
  });

  factory RepoModel.fromJson(Map<String, dynamic> json) {
    return RepoModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      fullName: json['full_name'] ?? '',
      description: json['description'],
      private: json['private'] ?? false,
      htmlUrl: json['html_url'] ?? '',
      stargazersCount: json['stargazers_count'] ?? 0,
      watchersCount: json['watchers_count'] ?? 0,
      forksCount: json['forks_count'] ?? 0,
      language: json['language'],
      createdAt: DateTime.parse(json['created_at'] ?? DateTime.now().toIso8601String()),
      updatedAt: DateTime.parse(json['updated_at'] ?? DateTime.now().toIso8601String()),
      openIssuesCount: json['open_issues_count'] ?? 0,
      defaultBranch: json['default_branch'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'full_name': fullName,
      'description': description,
      'private': private,
      'html_url': htmlUrl,
      'stargazers_count': stargazersCount,
      'watchers_count': watchersCount,
      'forks_count': forksCount,
      'language': language,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'open_issues_count': openIssuesCount,
      'default_branch': defaultBranch,
    };
  }
}