// lib/presentation/providers/user_provider.dart
import 'package:flutter/material.dart';
import '../Domain/Entities/user.dart';
import '../Domain/usecases/get_users_by_location.dart';

class UserProvider with ChangeNotifier {
  final GetUsersByLocation getUsersByLocation;
  List<User> _users = [];
  List<User> get users => _users;

  UserProvider({required this.getUsersByLocation});

  Future<void> fetchUsers(String location) async {
    _users = await getUsersByLocation(location);
    notifyListeners();
  }
}
