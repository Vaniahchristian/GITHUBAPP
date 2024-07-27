import 'package:equatable/equatable.dart';

class GitHubUserEntity extends Equatable {
  final String login;
  final String avatarUrl;
  final String htmlUrl;
  final String? name;
  final String? company;
  final String? blog;
  final String? location;
  final String? email;
  final String? bio;
  final int? publicRepos;
  final int? followers;
  final int? following;

  const GitHubUserEntity({
    required this.login,
    required this.avatarUrl,
    required this.htmlUrl,
    this.name,
    this.company,
    this.blog,
    this.location,
    this.email,
    this.bio,
    this.publicRepos,
    this.followers,
    this.following,
  });

  @override
  List<Object?> get props => [
    login,
    avatarUrl,
    htmlUrl,
    name,
    company,
    blog,
    location,
    email,
    bio,
    publicRepos,
    followers,
    following,
  ];
}
