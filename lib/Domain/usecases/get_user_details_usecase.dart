import '../Entities/user.dart';
import '../Repositories/Details_repository.dart';


class GetUserDetailsUsecase {
  final DetailsRepository repository;

  GetUserDetailsUsecase({required this.repository});

  Future<Map<String, dynamic>> call(String username) async {
    return await repository.getUserDetails(username);
  }
}



