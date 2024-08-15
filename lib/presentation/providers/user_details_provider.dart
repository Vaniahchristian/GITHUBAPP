



import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import '../../domain/entities/gitHub_user_detail_entity.dart';
import '../../domain/usecases/fetch_user_details.dart';

class UserDetailsProvider extends ChangeNotifier {

  final FetchUserDetailsUsecase _fetchUserDetailsUsecase = GetIt.instance<FetchUserDetailsUsecase>();
  GitHubUserDetailEntity? _userDetails;
  bool _isLoading = false;
  String? _error;



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
