
import 'package:githubapp/Domain/Entities/github_user_entity.dart';

import '../Repositories/github_repository.dart';



class fetchUsersByLocationUsecase {
  final GitHubRepository repository;

  fetchUsersByLocationUsecase(this.repository);

  Future<List<GitHubUserEntity>> call(String location) async {
    return await repository.fetchUsersByLocation(location);
  }
}


class fetchUserDetailsUsecase {
  final GitHubRepository repository;

  fetchUserDetailsUsecase(this.repository);

  Future<GitHubUserEntity> call(String username) async {
    return await repository.fetchUserDetails(username);
  }
}

