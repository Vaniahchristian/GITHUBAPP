import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import '../Services/github_service.dart';
import '../Models/github_user.dart';

class UserDetails extends StatelessWidget {
  final GitHubUser user;

  UserDetails({required this.user});

  void _shareProfile(GitHubUser user) {
    final String text = '''
  GitHub User Profile:
  Username: ${user.login}
  Name: ${user.name ?? 'N/A'}
  Location: ${user.location ?? 'N/A'}
  Public Repositories: ${user.publicRepos ?? 'N/A'}
  Followers: ${user.followers ?? 'N/A'}
  Following: ${user.following ?? 'N/A'}
  Profile URL: ${user.htmlUrl}
    ''';

    Share.share(text);
  }

  @override
  Widget build(BuildContext context) {
    GitHubService _githubService = GitHubService();

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        title: Text(user.login,
          style: TextStyle(color: Colors.white),),
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () => _shareProfile(user),
          ),

        ],
        backgroundColor: Colors.blue,

      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _githubService.fetchUserDetails(user.login),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('No details found'));
          } else {
            final userDetails = GitHubUser.fromJson(snapshot.data!);

            return Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(userDetails.avatarUrl),
                      radius: 50,


                    ),


                  ),
                  SizedBox(height: 16),
                  Text(
                    'Username: ${userDetails.login}',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  if (userDetails.name != null)
                    Text(
                      'Name: ${userDetails.name}',
                      style: TextStyle(fontSize: 16),
                    ),
                  Divider(
                    thickness: 1.0,
                    color: Colors.grey,
                    height: 10.0,
                  ),
                  if (userDetails.location != null)
                    Text(
                      'Location: ${userDetails.location}',
                      style: TextStyle(fontSize: 16),
                    ),

                  Divider(
                    thickness: 1.0,
                    color: Colors.grey,
                    height: 10.0,
                  ),
                  Text(
                    'Public Repositories: ${userDetails.publicRepos}',
                    style: TextStyle(fontSize: 16),
                  ),

                  Divider(
                    thickness: 1.0,
                    color: Colors.grey,
                    height: 10.0,
                  ),
                  Text(
                    'Followers: ${userDetails.followers}',
                    style: TextStyle(fontSize: 16),
                  ),

                  Divider(
                    thickness: 1.0,
                    color: Colors.grey,
                    height: 10.0,
                  ),
                  Text(
                    'Following: ${userDetails.following}',
                    style: TextStyle(fontSize: 16),
                  ),

                  Divider(
                    thickness: 1.0,
                    color: Colors.grey,
                    height: 10.0,
                  ),
                  if (userDetails.bio != null)
                    Text(
                      'Bio: ${userDetails.bio}',
                      style: TextStyle(fontSize: 16),
                    ),

                  if (userDetails.email != null)
                    Text(
                      'Email: ${userDetails.email}',
                      style: TextStyle(fontSize: 16),
                    ),

                  Divider(
                    thickness: 1.0,
                    color: Colors.grey,
                    height: 10.0,
                  ),

                  if (userDetails.company != null)
                    Text(
                      'Company: ${userDetails.company}',
                      style: TextStyle(fontSize: 16),
                    ),

                  Divider(
                    thickness: 1.0,
                    color: Colors.grey,
                    height: 10.0,
                  ),

                  if (userDetails.blog != null)
                    Text(
                      'Blog: ${userDetails.blog}',
                      style: TextStyle(fontSize: 16),
                    ),

                  Divider(
                    thickness: 1.0,
                    color: Colors.grey,
                    height: 10.0,
                  ),


                  SizedBox(height: 16),
                  Text(
                    'Profile URL:',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  InkWell(
                    child: Text(
                      userDetails.htmlUrl,
                      style: TextStyle(fontSize: 16, color: Colors.blue),
                    ),
                    onTap: () {
                      // Handle URL tap if necessary
                    },
                  ),


                  Divider( // Creates a horizontal line
                    thickness: 1.0, // Adjust thickness as needed
                    color: Colors.grey, // Change color if desired
                    height: 10.0, // Controls the space occupied by the divider
                  )
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
