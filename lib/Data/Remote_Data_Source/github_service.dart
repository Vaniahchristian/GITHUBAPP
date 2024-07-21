import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class GitHubService {
  static const String baseUrl = 'https://api.github.com/search/users';

  Future<List<dynamic>> fetchUsersByLocation(String location,{int page = 1, int perPage = 30}) async {
    final response = await http.get(Uri.parse('$baseUrl?q=location:$location &page=$page&per_page=$perPage'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['items'];
    } else {
      throw Exception('Failed to load users');
    }
  }

  Future<Map<String, dynamic>> fetchUserDetails(String username) async {
    final response = await http.get(Uri.parse('https://api.github.com/users/$username'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load user details');
    }
  }


  Future<List<dynamic>> fetchUsersByFilter({
    required String name,
    int minFollowers = 0,
    int minRepos = 0,
  }) async {
    final url = 'https://api.github.com/search/users?q=$name+followers:>=$minFollowers+repos:>=$minRepos';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['items'];
    } else {
      throw Exception('Failed to load users');
    }
  }



}





