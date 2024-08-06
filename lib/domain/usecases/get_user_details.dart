import 'package:githubapp/domain/entities/github_user_detail_entity.dart';
import '../Entities/user_entity.dart';
import '../Repositories/github_repository.dart';

class FetchUserDetailsUsecase {
  final GitHubRepository repository;

  FetchUserDetailsUsecase(this.repository);

  Future<GitHubUserDetailEntity> call(String username) async {
    return await repository.fetchUserDetails(username);
  }
}
