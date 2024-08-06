
import '../../Domain/Entities/user_entity.dart';

class GitHubUserModel extends GitHubUserEntity {
  const GitHubUserModel({
    required String login,
    required String avatarUrl,
    required String htmlUrl,
    String name = '',
    String company = '',
    String blog = '',
    String location = '',
    String email = '',
    String bio = '',
    int publicRepos = 0,
    int followers = 0,
    int following = 0,
  }) : super(
    login: login,
    avatarUrl: avatarUrl,
    htmlUrl: htmlUrl,
    name: name,
    company: company,
    blog: blog,
    location: location,
    email: email,
    bio: bio,
    publicRepos: publicRepos,
    followers: followers,
    following: following,
  );

  factory GitHubUserModel.fromJson(Map<String, dynamic> json) {
    return GitHubUserModel(
      login: json['login'] ?? '',
      avatarUrl: json['avatar_url'] ?? '',
      htmlUrl: json['html_url'] ?? '',
      name: json['name'] ?? '',
      company: json['company'] ?? '',
      blog: json['blog'] ?? '',
      location: json['location'] ?? '',
      email: json['email'] ?? '',
      bio: json['bio'] ?? '',
      publicRepos: json['public_repos'] ?? 0,
      followers: json['followers'] ?? 0,
      following: json['following'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'login': login,
      'avatar_url': avatarUrl,
      'html_url': htmlUrl,
      'name': name,
      'company': company,
      'blog': blog,
      'location': location,
      'email': email,
      'bio': bio,
      'public_repos': publicRepos,
      'followers': followers,
      'following': following,
    };
  }

  GitHubUserEntity toEntity() {
    return GitHubUserEntity(
      login: login,
      avatarUrl: avatarUrl,
      htmlUrl: htmlUrl,
      name: name,
      company: company,
      blog: blog,
      location: location,
      email: email,
      bio: bio,
      publicRepos: publicRepos,
      followers: followers,
      following: following,
    );
  }
}
