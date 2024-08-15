import 'package:get_it/get_it.dart';
import '../entities/github_user_entity.dart';
import '../repositories/github_repository.dart';

class FetchUsersByLocationUsecase {
  final GitHubRepository repository = GetIt.instance<GitHubRepository>();

  Future<List<GitHubUserEntity>> call(String location) async {
    return await repository.fetchUsersByLocation(location);
  }
}
