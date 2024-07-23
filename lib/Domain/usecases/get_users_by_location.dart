// lib/domain/usecases/get_users_by_location.dart


import '../Entities/user.dart';
import '../Repositories/user_repository.dart';

class GetUsersByLocation {
  final UserRepository repository;

  GetUsersByLocation(this.repository);

  Future<List<User>> call(String location) async {
    return await repository.getUsersByLocation(location);
  }
}

