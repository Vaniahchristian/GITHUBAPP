import 'package:flutter/material.dart';
import '../../domain/entities/user.dart';
import '../Data/Models/github_user.dart';
import '../Domain/usecases/get_user_details_usecase.dart';


class DetailsProvider with ChangeNotifier {
  final GetUserDetailsUsecase getUserDetailsUsecase;
  GitHubUser? _userDetail; // Update this to GitHubUser
  bool _isLoading = false;
  String? _errorMessage;

  GitHubUser? get userDetail => _userDetail;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  DetailsProvider({required this.getUserDetailsUsecase});

  Future<void> fetchUserDetails(String username) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final result = await getUserDetailsUsecase(username);
      _userDetail = GitHubUser.fromJson(result); // Use GitHubUser here
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _errorMessage = e.toString();
      notifyListeners();
    }
  }
}
