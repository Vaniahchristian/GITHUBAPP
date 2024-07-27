import 'dart:convert';
import 'package:githubapp/Domain/Repositories/github_repository.dart';
import 'package:http/http.dart' as http;

import '../Models/github_user_model.dart';

class GitHubRepositoryImpl implements GitHubRepository {
  static const String baseUrl = 'https://api.github.com/search/users';

  @override
  Future<List<GitHubUserModel>> fetchUsersByLocation(String location, {int page = 1, int perPage = 30}) async {
    final response = await http.get(Uri.parse('$baseUrl?q=location:$location&page=$page&per_page=$perPage'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return (data['items'] as List).map((item) => GitHubUserModel.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load users');
    }
  }

  @override
  Future<GitHubUserModel> fetchUserDetails(String username) async {
    final response = await http.get(Uri.parse('https://api.github.com/users/$username'));

    if (response.statusCode == 200) {
      return GitHubUserModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load user details');
    }
  }

  @override
  Future<List<GitHubUserModel>> fetchUsersByFilter({required String name, int minFollowers = 0, int minRepos = 0}) async {
    final url = 'https://api.github.com/search/users?q=$name+followers:>=$minFollowers+repos:>=$minRepos';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return (data['items'] as List).map((item) => GitHubUserModel.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load users');
    }
  }
}
