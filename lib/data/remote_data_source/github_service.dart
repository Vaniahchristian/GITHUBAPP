import 'dart:convert';
import 'package:githubapp/data/models/gitHub_user_detail_model.dart';
import 'package:githubapp/data/models/github_user_model.dart';
import 'package:http/http.dart' as http;

class GitHubService {
  static const String baseUrl = 'https://api.github.com';

  Future<List<GitHubUserModel>> fetchUsersByLocation(String location, {int page = 1, int perPage = 30}) async {
    final response = await http.get(Uri.parse('$baseUrl/search/users?q=location:$location&page=$page&per_page=$perPage'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return (data['items'] as List).map((item) => GitHubUserModel.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load users');
    }
  }

  Future<GitHubUserDetailModel> fetchUserDetails(String username) async {
    final response = await http.get(Uri.parse('$baseUrl/users/$username'));

    if (response.statusCode == 200) {
      return GitHubUserDetailModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load user details');
    }
  }

  Future<List<GitHubUserModel>> fetchUsersByFilter({
    required String name,
    int? exactFollowers,
    int? exactRepos,
  }) async {
    final StringBuffer query = StringBuffer();
    query.write('$baseUrl/search/users?q=$name');

    if (exactFollowers != null) {
      query.write('+followers:>=$exactFollowers');
    }

    if (exactRepos != null) {
      query.write('+repos:>=$exactRepos');
    }

    final response = await http.get(Uri.parse(query.toString()));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return (data['items'] as List).map((item) => GitHubUserModel.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load users');
    }
  }
}
