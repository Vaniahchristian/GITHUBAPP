



import '../entities/github_user_entity.dart';
import '../repositories/github_repository.dart';

class FetchUsersByLocationUsecase {
  final GitHubRepository repository;

  FetchUsersByLocationUsecase(this.repository);

  Future<List<GitHubUserEntity>> call(String location) async {
    return await repository.fetchUsersByLocation(location);
  }
}
