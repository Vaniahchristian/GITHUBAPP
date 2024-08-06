
import 'package:githubapp/data/models/gitHub_user_detail_model.dart';
import 'package:githubapp/data/models/github_user_model.dart';
import 'package:githubapp/data/remote_data_source/github_service.dart';
import 'package:githubapp/domain/entities/user_entity.dart';
import 'package:githubapp/domain/entities/github_user_detail_entity.dart';
import 'package:githubapp/domain/repositories/github_repository.dart';



class GitHubRepositoryImpl implements GitHubRepository {
  final GitHubService gitHubService;

  GitHubRepositoryImpl({required this.gitHubService});

  @override
  Future<GitHubUserDetailEntity> fetchUserDetails(String username) async {
    final GitHubUserDetailModel userDetailModel = await gitHubService.fetchUserDetails(username);
    return userDetailModel.toEntity();
  }


  @override
  Future<List<GitHubUserEntity>> fetchUsersByLocation(String location, {int page = 1, int perPage = 30}) async {
    final List<GitHubUserModel> userModels = await gitHubService.fetchUsersByLocation(location, page: page, perPage: perPage);
    return userModels.map((model) => model.toEntity()).toList();
  }

  @override
  Future<List<GitHubUserEntity>> fetchUsersByFilter({required String name, int minFollowers = 0, int minRepos = 0}) async {
    final List<GitHubUserModel> userModels = await gitHubService.fetchUsersByFilter(name: name, exactFollowers: minFollowers, exactRepos: minRepos);
    return userModels.map((model) => model.toEntity()).toList();
  }
}
