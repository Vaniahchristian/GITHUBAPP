import 'package:equatable/equatable.dart';

class GitHubUserDetailEntity extends Equatable {

  final String login;
  final String avatarUrl;
  final String htmlUrl;
  final String? name;
  final String company;
  final String? blog;
  final String? location;
  final String email;
  final String? bio;
  final int publicRepos;
  final int followers;
  final int following;

  const GitHubUserDetailEntity({
    required this.login,
    required this.avatarUrl,
    required this.htmlUrl,
    this.name = '',
    this.company = '',
    this.blog = '',
    this.location = '',
    this.email = '',
    this.bio = '',
    required this.publicRepos,
    required this.followers,
    required this.following,
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
