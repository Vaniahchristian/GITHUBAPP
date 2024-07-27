import 'package:flutter/cupertino.dart';

import '../Data/Models/github_user_model.dart';
import '../Data/Remote_Data_Source/github_service.dart';

class UserProvider extends ChangeNotifier {
  final GitHubService _githubService = GitHubService();
  List<GitHubUserModel> _users = [];

  List<GitHubUserModel> get users => _users;

  Future<void> fetchUsersByLocation(String location) async {
    try {
      final fetchedUsers = await _githubService.fetchUsersByLocation(location);
      _users = fetchedUsers;
      notifyListeners();
    } catch (e) {
      // Handle error appropriately (e.g., show a message to the user)
      print('Failed to fetch users: $e');
    }
  }
}
