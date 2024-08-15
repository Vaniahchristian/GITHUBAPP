


import 'package:get_it/get_it.dart';
import '../entities/gitHub_user_detail_entity.dart';
import '../repositories/github_repository.dart';

class FetchUserDetailsUsecase {

  final GitHubRepository repository = GetIt.instance<GitHubRepository>();

  Future<GitHubUserDetailEntity> call(String username) async {
    return await repository.fetchUserDetails(username);
  }
}