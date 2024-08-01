import 'package:flutter/cupertino.dart';
import '../Data/Models/github_user_model.dart';
import '../Data/Remote_Data_Source/github_service.dart';

class FilterProvider extends ChangeNotifier {
  final GitHubService _githubService = GitHubService();
  List<GitHubUserModel> _filteredUsers = [];

  List<GitHubUserModel> get filteredUsers => _filteredUsers;

  Future<void> fetchUsersByFilter(String name, {int? exactFollowers, int? exactRepos}) async {
    try {
      final fetchedUsers = await _githubService.fetchUsersByFilter(
        name: name,
        exactFollowers: exactFollowers,
        exactRepos: exactRepos,
      );
      _filteredUsers = fetchedUsers;
      notifyListeners();
    } catch (e) {
      // Handle error appropriately (e.g., show a message to the user)
      print('Failed to fetch filtered users: $e');
    }
  }
}
