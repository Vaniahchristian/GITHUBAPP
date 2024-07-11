import 'package:flutter/material.dart';
import 'github_service.dart';
import 'github_user.dart';
import 'user_details.dart';

GitHubService _githubService = GitHubService();

Widget UserList(BuildContext context, String location) {
  return Scaffold(
    appBar: AppBar(
      title: Text('Users in $location',
        style: TextStyle(color: Colors.white),),
      backgroundColor: Colors.blue,
    ),
    body: FutureBuilder<List<dynamic>>(
      future: _githubService.fetchUsersByLocation(location),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No users found'));
        } else {
          final users = snapshot.data!
              .map((json) => GitHubUser.fromJson(json))
              .toList();

          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(user.avatarUrl),
                ),
                title: Text(user.login),
                subtitle: Text(user.htmlUrl),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UserDetails(user: user),
                    ),
                  );
                },
              );
            },
          );
        }
      },
    ),
  );
}
