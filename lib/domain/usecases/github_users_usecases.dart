
import 'package:githubapp/domain/entities/user_entity.dart';
import '../Repositories/github_repository.dart';



class fetchUsersByLocationUsecase {
  final GitHubRepository repository;

  fetchUsersByLocationUsecase(this.repository);

  Future<List<GitHubUserEntity>> call(String location) async {
    return await repository.fetchUsersByLocation(location);
  }
}




