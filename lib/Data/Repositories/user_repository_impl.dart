// lib/data/repositories/user_repository_impl.dart


import '../../Domain/Entities/user.dart';
import '../../Domain/Repositories/user_repository.dart';
import '../Remote_Data_Source/github_service.dart';

class UserRepositoryImpl implements UserRepository {
  final GitHubService githubService;

  UserRepositoryImpl({required this.githubService});

  @override
  Future<List<User>> getUsersByLocation(String location) async {
    return await githubService.getUsersByLocation(location);
  }
}
