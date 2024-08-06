
import 'package:githubapp/domain/entities/github_user_detail_entity.dart';

class GitHubUserDetailModel extends GitHubUserDetailEntity {
  const GitHubUserDetailModel({
    required super.login,
    required super.avatarUrl,
    required super.htmlUrl,
    super.name = null,
    super.company,
    super.blog = null,
    super.location = null,
    super.email,
    super.bio = null,
    super.publicRepos = 0,
    super.followers = 0,
    super.following = 0,
  });

  factory GitHubUserDetailModel.fromJson(Map<String, dynamic> json) {
    return GitHubUserDetailModel(
      login: json['login'] ?? '',
      avatarUrl: json['avatar_url'] ?? '',
      htmlUrl: json['html_url'] ?? '',
      name: json['name'],
      company: json['company'] ?? '',
      blog: json['blog'],
      location: json['location'],
      email: json['email'] ?? '',
      bio: json['bio'],
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

  factory GitHubUserDetailModel.fromEntity(GitHubUserDetailEntity entity) {
    return GitHubUserDetailModel(
      login: entity.login,
      avatarUrl: entity.avatarUrl,
      htmlUrl: entity.htmlUrl,
      name: entity.name,
      company: entity.company,
      blog: entity.blog,
      location: entity.location,
      email: entity.email,
      bio: entity.bio,
      publicRepos: entity.publicRepos,
      followers: entity.followers,
      following: entity.following,
    );
  }

  GitHubUserDetailEntity toEntity() {
    return GitHubUserDetailEntity(
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
