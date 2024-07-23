import 'package:flutter/foundation.dart';
import '../../../Data/Models/github_user.dart';
import '../../../Data/Remote_Data_Source/github_service.dart';

class GitHubUserProvider with ChangeNotifier {
  final GitHubService _githubService = GitHubService();
  GitHubUser? _userDetails;
  bool _isLoading = false;
  String? _error;

  GitHubUser? get userDetails => _userDetails;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchUserDetails(String username) async {
    _isLoading = true;
    notifyListeners();

    try {
      final data = await _githubService.fetchUserDetails(username);
      _userDetails = GitHubUser.fromJson(data);
      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
