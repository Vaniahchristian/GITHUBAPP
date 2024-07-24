import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

import '../Models/github_user.dart';

class GitHubService {
  static const String baseUrl = 'https://api.github.com/search/users';

  Future<List<dynamic>> fetchUsersByLocation(String location,
      {int page = 1, int perPage = 30}) async {
    final response = await http.get(Uri.parse(
        '$baseUrl?q=location:$location &page=$page&per_page=$perPage'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['items'];
    } else {
      throw Exception('Failed to load users');
    }
  }




  Future<Map<String, dynamic>> fetchUserDetails(String username) async {
    final response = await http.get(
        Uri.parse('https://api.github.com/users/$username'));

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



  





  //Future<List<dynamic>> getUsersByLocation(String location) async {
    // Set default page and perPage values
   // const int page = 1;
   // const int perPage = 30;

    // Construct the URL for the API request
    //final String url = '$baseUrl?q=location:$location&page=$page&per_page=$perPage';

    // Perform the HTTP GET request
   // final response = await http.get(Uri.parse(url));

    // Check if the response status code is 200 (OK)
    //if (response.statusCode == 200) {
      // Decode the JSON response
    //  final data = json.decode(response.body);
      // Return the list of users
    //  return data['items'];
   // } else {
      // Throw an exception if the request failed
    //  throw Exception('Failed to load users');
  //  }
 // }
}


