import 'package:flutter/cupertino.dart';

import '../../domain/entities/github_user_entity.dart';
import '../../domain/usecases/filter_users_usecase.dart';

class FilterProvider extends ChangeNotifier {
  final FilterUsersUsecase _filterUsersUsecase;

  List<GitHubUserEntity> _filteredUsers = [];

  List<GitHubUserEntity> get filteredUsers => _filteredUsers;

  FilterProvider(this._filterUsersUsecase);

  Future<void> fetchUsersByFilter(String name) async {
    try {
      final fetchedUsers = await _filterUsersUsecase.call(name);
      _filteredUsers = fetchedUsers;
      notifyListeners();
    } catch (e) {
      print('Failed to fetch filtered users: $e');
    }
  }
}
