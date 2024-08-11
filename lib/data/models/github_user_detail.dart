import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/gitHub_user_detail_entity.dart';

part 'github_user_detail.g.dart';

@JsonSerializable()
class GitHubUserDetailModel extends GitHubUserDetailEntity {
  const GitHubUserDetailModel({
    required super.login,
    required super.avatarUrl,
    required super.htmlUrl,
    String super.name,
    super.company,
    String super.blog,
    String super.location,
    super.email,
    String super.bio,
    super.publicRepos = 0,
    super.followers = 0,
    super.following = 0,
  });

  factory GitHubUserDetailModel.fromJson(Map<String, dynamic> json) => _$GitHubUserDetailModelFromJson(json);

  Map<String, dynamic> toJson() => _$GitHubUserDetailModelToJson(this);

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
