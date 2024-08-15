import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import '../../domain/entities/github_user_entity.dart';
import '../../domain/usecases/github_users_usecase.dart';

class UserProvider extends ChangeNotifier {
  final FetchUsersByLocationUsecase _fetchUsersByLocationUsecase =
      GetIt.instance<FetchUsersByLocationUsecase>();

  List<GitHubUserEntity> _users = [];

  List<GitHubUserEntity> get users => _users;

  Future<void> fetchUsersByLocation(String location) async {
    try {
      final fetchedUsers = await _fetchUsersByLocationUsecase.call(location);
      _users = fetchedUsers;
      notifyListeners();
    } catch (e) {
      print('Failed to fetch users: $e');
    }
  }
}
