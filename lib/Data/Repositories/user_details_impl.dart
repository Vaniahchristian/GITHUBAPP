import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../Domain/Repositories/Details_repository.dart';
import '../Remote_Data_Source/github_service.dart';

class UserDetailsImpl implements DetailsRepository {
  final GitHubService githubService;

  UserDetailsImpl({required this.githubService});

  @override
  Future<Map<String, dynamic>> getUserDetails(String username) async {
    try {
      // Fetch user details from the GitHub service
      final response = await githubService.fetchUserDetails(username);

      // Check if the response is a valid JSON map
      if (response is Map<String, dynamic>) {
        return response;
      } else {
        throw Exception('Invalid response format');
      }
    } catch (e) {
      // Handle any errors that occur during the request
      throw Exception('Failed to load user details: $e');
    }
  }
}
