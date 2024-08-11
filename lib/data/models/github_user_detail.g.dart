// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'github_user_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GitHubUserDetailModel _$GitHubUserDetailModelFromJson(
        Map<String, dynamic> json) =>
    GitHubUserDetailModel(
      login: json['login'] as String,
      avatarUrl: json['avatar_url'] as String,
      htmlUrl: json['html_url'] as String,
      name: json['name'] as String? ?? '',
      company: json['company'] as String? ?? '',
      blog: json['blog'] as String? ?? '',
      location: json['location'] as String? ?? '',
      email: json['email'] as String? ?? '',
      bio: json['bio'] as String? ?? '',
      publicRepos: (json['publicRepos'] as num?)?.toInt() ?? 0,
      followers: (json['followers'] as num?)?.toInt() ?? 0,
      following: (json['following'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$GitHubUserDetailModelToJson(
        GitHubUserDetailModel instance) =>
    <String, dynamic>{
      'login': instance.login,
      'avatarUrl': instance.avatarUrl,
      'htmlUrl': instance.htmlUrl,
      'name': instance.name,
      'company': instance.company,
      'blog': instance.blog,
      'location': instance.location,
      'email': instance.email,
      'bio': instance.bio,
      'publicRepos': instance.publicRepos,
      'followers': instance.followers,
      'following': instance.following,
    };
