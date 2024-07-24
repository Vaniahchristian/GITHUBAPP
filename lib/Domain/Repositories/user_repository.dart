// lib/domain/repositories/user_repository.dart

import 'dart:convert';

import 'package:http/http.dart' as http;
import '../Entities/user.dart';

abstract class UserRepository {
  Future<List<dynamic>> getUsers(String location);
}

