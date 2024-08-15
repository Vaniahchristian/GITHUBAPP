import '../../domain/entities/github_user_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'github_user.g.dart';

@JsonSerializable()
class GitHubUserModel extends GitHubUserEntity {
  const GitHubUserModel({
    required super.login,
    required super.avatarUrl,
    required super.htmlUrl,
    String super.name = '',
    String super.company = '',
    String super.blog = '',
    String super.location = '',
    String super.email = '',
    String super.bio = '',
    int super.publicRepos = 0,
    int super.followers = 0,
    int super.following = 0,
  });

  factory GitHubUserModel.fromJson(Map<String, dynamic> json) =>
      _$GitHubUserModelFromJson(json);



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
