import '../../Domain/Entities/github_user_entity.dart';

class GitHubUserModel extends GitHubUserEntity {
  const GitHubUserModel({
    required String login,
    required String avatarUrl,
    required String htmlUrl,
    String? name,
    String? location,
    int? publicRepos,
    int? followers,
    int? following,
    String? bio,
    String? email,
    String? company,
    String? blog,
  }) : super(
    login: login,
    avatarUrl: avatarUrl,
    htmlUrl: htmlUrl,
    name: name,
    location: location,
    publicRepos: publicRepos,
    followers: followers,
    following: following,
    bio: bio,
    email: email,
    company: company,
    blog: blog,
  );

  factory GitHubUserModel.fromJson(Map<String, dynamic> json) {
    return GitHubUserModel(
      login: json['login'],
      avatarUrl: json['avatar_url'],
      htmlUrl: json['html_url'],
      name: json['name'],
      location: json['location'],
      publicRepos: json['public_repos'],
      followers: json['followers'],
      following: json['following'],
      bio: json['bio'],
      email: json['email'],
      company: json['company'],
      blog: json['blog'],
    );
  }
}
