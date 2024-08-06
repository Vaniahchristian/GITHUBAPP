import 'package:flutter/material.dart';
import 'package:githubapp/domain/entities/github_user_detail_entity.dart';
import '../domain/usecases/get_user_details.dart';

class UserDetailsProvider extends ChangeNotifier {
  final FetchUserDetailsUsecase _fetchUserDetailsUsecase;
  GitHubUserDetailEntity? _userDetails;
  bool _isLoading = false;
  String? _error;

  UserDetailsProvider(this._fetchUserDetailsUsecase);

  GitHubUserDetailEntity? get userDetails => _userDetails;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchUserDetails(String username) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final userDetails = await _fetchUserDetailsUsecase.call(username);
      _showUserDetails(userDetails);
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void _showUserDetails(GitHubUserDetailEntity userDetails) {
    _userDetails = userDetails;
    notifyListeners();
  }
}
