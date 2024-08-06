


import '../entities/github_user_detail_entity.dart';
import '../entities/user_entity.dart';

abstract class GitHubRepository {
  Future<List<GitHubUserEntity>> fetchUsersByLocation(String location, {int page, int perPage});
  Future<GitHubUserDetailEntity> fetchUserDetails(String username);
  Future<List<GitHubUserEntity>> fetchUsersByFilter({required String name, int minFollowers, int minRepos});
}
