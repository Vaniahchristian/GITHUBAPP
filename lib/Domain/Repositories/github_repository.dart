


import '../Entities/github_user_entity.dart';

abstract class GitHubRepository {
  Future<List<GitHubUserEntity>> fetchUsersByLocation(String location, {int page, int perPage});
  Future<GitHubUserEntity> fetchUserDetails(String username);
  Future<List<GitHubUserEntity>> fetchUsersByFilter({required String name, int minFollowers, int minRepos});
}
