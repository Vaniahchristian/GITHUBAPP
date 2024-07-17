import 'package:flutter/cupertino.dart';
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

        iconTheme: IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () => _shareProfile(user),
            color: Colors.white,
          ),

        ],
        backgroundColor: Color(0xFF000080),


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
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(userDetails.avatarUrl),
                        radius: 50,
                      ),
                    ),
                    SizedBox(height: 1),


                    Center(
                    child:Text(
                     '${userDetails.login}',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.grey),
                    ),
                   ),



                    SizedBox(height: 1),
                    if (userDetails.name != null)
                      InfoCard(
                        text: 'Name: ${userDetails.name}',
                        icon: Icons.person,
                      ),

                    SizedBox(height: 1),
                    if (userDetails.location != null)
                      InfoCard(
                        icon: Icons.location_on,
                        text: 'Location: ${userDetails.location}',
                      ),
                    SizedBox(height: 1),

                    InfoCard(
                      text: 'Public Repositories: ${userDetails.publicRepos}',
                      icon: Icons.storage,
                    ),

                    SizedBox(height: 1),

                    InfoCard(
                      text: 'Followers: ${userDetails.followers}',
                      icon: Icons.group,
                    ),
                    SizedBox(height: 1),

                    InfoCard(
                      text: 'Following: ${userDetails.following}',
                      icon: Icons.person_add,
                    ),
                    SizedBox(height: 1),

                    if (userDetails.bio != null)
                      InfoCard(
                        text: 'Bio: ${userDetails.bio}',
                        icon: Icons.info,
                      ),
                    SizedBox(height: 1),

                    if (userDetails.email != null)
                      InfoCard(
                        text: 'Email: ${userDetails.email}',
                        icon: Icons.email,
                      ),
                    SizedBox(height: 1),

                    if (userDetails.company != null)
                      InfoCard(
                        text: 'Company: ${userDetails.company}',
                        icon: Icons.business,
                      ),
                    SizedBox(height: 1),

                    if (userDetails.blog != null)
                      InfoCard(
                        text: 'Blog: ${userDetails.blog}',
                        icon: Icons.description,
                      ),

                    SizedBox(height: 1),

                    InfoCard(
                      text: 'Profile URL:',
                      icon: Icons.link,
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
                  ],
                ),
              ),
            );

          }
        },
      ),
    );
  }
}
class InfoCard extends StatelessWidget {
  final IconData icon;
  final String text;

  InfoCard({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(icon),
        title: Text(text),
      ),
    );
  }
}