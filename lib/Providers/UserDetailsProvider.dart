import 'package:flutter/material.dart';
import '../Data/Models/github_user_detail_model.dart';
import '../Data/Remote_Data_Source/github_service.dart';


class UserDetailsProvider with ChangeNotifier {
  final GitHubService _gitHubService = GitHubService();
  GitHubUserDetailModel? _userDetails;
  bool _isLoading = false;
  String? _error;

  GitHubUserDetailModel? get userDetails => _userDetails;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchUserDetails(String username) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _userDetails = await _gitHubService.fetchUserDetails(username);
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
