import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import '../../Data/Remote_Data_Source/github_service.dart';
import '../../Data/Models/github_user_model.dart';

class UserDetails extends StatelessWidget {
  final GitHubUserModel user;

  UserDetails({required this.user});

  void _shareProfile(GitHubUserModel user) {
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
        title: Text(
          user.login,
          style: TextStyle(color: Colors.white),
        ),
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
      body: FutureBuilder<GitHubUserModel>(
        future: _githubService.fetchUserDetails(user.login),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('No details found'));
          } else {
            final userDetails = snapshot.data!;

            return Padding(
              padding: EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(userDetails.avatarUrl),
                        radius: 50,
                      ),
                    ),
                    SizedBox(height: 10),
                    Center(
                      child: Text(
                        userDetails.login,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(height: 4),
                    if (userDetails.name != null)
                      Text(
                        userDetails.name!,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey[700],
                        ),
                      ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildStatColumn("Repositories", userDetails.publicRepos.toString()),
                        _buildStatColumn("Followers", userDetails.followers.toString()),
                        _buildStatColumn("Following", userDetails.following.toString()),
                      ],
                    ),
                    Divider(),
                    SizedBox(height: 8),
                    Card(
                      elevation: 4,
                      margin: EdgeInsets.all(8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: userDetails.bio != null
                            ? Text(
                          userDetails.bio!,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.center,
                        )
                            : SizedBox.shrink(),
                      ),
                    ),
                    SizedBox(height: 16),
                    _buildInfoRow(Icons.location_on, userDetails.location),
                    _buildInfoRow(Icons.email, userDetails.email),
                    _buildInfoRow(Icons.business, userDetails.company),
                    _buildInfoRow(Icons.description, userDetails.blog),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        Icon(Icons.link, color: Colors.grey),
                        SizedBox(width: 8),
                        Expanded(
                          child: InkWell(
                            child: Text(
                              userDetails.htmlUrl,
                              style: TextStyle(fontSize: 16, color: Colors.blue),
                            ),
                            onTap: () {
                              // Handle URL tap if necessary
                            },
                          ),
                        ),
                      ],
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

  Widget _buildStatColumn(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildInfoRow(IconData icon, String? info) {
    if (info == null || info.isEmpty) return SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.grey),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              info,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
