import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import '../../domain/entities/github_user_entity.dart';
import '../../domain/usecases/filter_users_usecase.dart';

class FilterProvider extends ChangeNotifier {
  final FilterUsersUsecase _filterUsersUsecase = GetIt.instance<FilterUsersUsecase>();

  List<GitHubUserEntity> _filteredUsers = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<GitHubUserEntity> get filteredUsers => _filteredUsers;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchUsersByFilter(String name) async {
    _isLoading = true;
    notifyListeners();

    try {
      final fetchedUsers = await _filterUsersUsecase.call(name);
      _filteredUsers = fetchedUsers;
      _errorMessage = null;
    } catch (e) {
      _errorMessage = 'Failed to fetch filtered users: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
