


import '../entities/gitHub_user_detail_entity.dart';
import '../repositories/github_repository.dart';

class FetchUserDetailsUsecase {
  final GitHubRepository repository;

  FetchUserDetailsUsecase(this.repository);

  Future<GitHubUserDetailEntity> call(String username) async {
    return await repository.fetchUserDetails(username);
  }
}