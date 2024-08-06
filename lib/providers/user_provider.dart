import 'package:flutter/cupertino.dart';
import 'package:githubapp/domain/entities/user_entity.dart';
import '../domain/usecases/github_users_usecases.dart';

class UserProvider extends ChangeNotifier {
  final fetchUsersByLocationUsecase _fetchUsersByLocationUsecase;

  UserProvider(this._fetchUsersByLocationUsecase);

  List<GitHubUserEntity> _users = [];

  List<GitHubUserEntity> get users => _users;

  Future<void> fetchUsersByLocation(String location) async {
    try {
      final fetchedUsers = await _fetchUsersByLocationUsecase.call(location);
      _users = fetchedUsers;
      notifyListeners();
    } catch (e) {
      // Handle error appropriately (e.g., show a message to the user)
      print('Failed to fetch users: $e');
    }
  }
}
