



import '../../domain/entities/gitHub_user_detail_entity.dart';
import '../../domain/entities/github_user_entity.dart';
import '../../domain/repositories/github_repository.dart';
import '../datasource/remote_data_source/github_service.dart';
import '../models/github_user.dart';

class GitHubRepositoryImpl implements GitHubRepository {
  final GitHubService _gitHubService;

  GitHubRepositoryImpl(this._gitHubService);




  @override
  Future<List<GitHubUserEntity>> fetchUsersByLocation(String location, {int page = 1, int perPage = 30}) async {
    final List<GitHubUserModel> userModels = await _gitHubService.fetchUsersByLocation(location, page: page, perPage: perPage);
    return userModels.map((model) => model.toEntity()).toList();
  }

  @override
  Future<List<GitHubUserEntity>> fetchUsersByFilter({required String name, int minFollowers = 0, int minRepos = 0}) async {
    final List<GitHubUserModel> userModels = await _gitHubService.fetchUsersByFilter(name: name, exactFollowers: minFollowers, exactRepos: minRepos);
    return userModels.map((model) => model.toEntity()).toList();
  }

  @override
  Future<GitHubUserDetailEntity> fetchUserDetails(String username) async {
    final  userDetails = await _gitHubService.fetchUserDetails(username);
    return userDetails.toEntity();

  }
}
