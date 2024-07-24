// lib/domain/usecases/users_usecase.dart


import '../Entities/user.dart';
import '../Repositories/user_repository.dart';

class GetUsersByLocation {
  final UserRepository repository;

  GetUsersByLocation(this.repository);

  Future<List<dynamic>> call(String location) async {
    return await repository.getUsers(location);
  }
}

