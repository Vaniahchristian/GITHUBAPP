import 'package:get_it/get_it.dart';

import '../entities/github_user_entity.dart';
import '../repositories/github_repository.dart';

class FilterUsersUsecase {
 // final GitHubRepository repository;

 // FilterUsersUsecase(this.repository);

  final GitHubRepository repository = GetIt.instance<GitHubRepository>();

  Future<List<GitHubUserEntity>> call(String username) async {
    return await repository.fetchUsersByFilter(name: username);
  }
}
