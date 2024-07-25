import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../Domain/Repositories/Details_repository.dart';
import '../Remote_Data_Source/github_service.dart';


class UserDetailsImpl implements DetailsRepository {
  final GitHubService githubService;

  UserDetailsImpl({required this.githubService});

  @override
  Future<Map<String, dynamic>> getUserDetails(String username) async {
    final response = await githubService.fetchUserDetails(username);

    if (response is Map<String, dynamic>) {
      return response;
    } else {
      throw Exception('Failed to load user details');
    }
  }
}
