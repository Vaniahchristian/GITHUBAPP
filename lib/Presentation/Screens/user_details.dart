import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../Data/Models/github_user.dart';
import '../../Data/Remote_Data_Source/github_service.dart';

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

  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    GitHubService _githubService = GitHubService();

    return Scaffold(
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

            return Column(
              children: [
                Container(
                  color: Color(0xFF36827F), // Background color for AppBar and container
                  child: Column(
                    children: [
                      AppBar(
                        toolbarHeight: 60,
                        title: Center(
                          child: Text(
                            user.login,
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        iconTheme: IconThemeData(color: Colors.white),
                        actions: [
                          IconButton(
                            icon: Icon(Icons.share),
                            onPressed: () => _shareProfile(user),
                            color: Colors.white,
                          ),
                        ],
                        backgroundColor: Colors.transparent, // Make AppBar background transparent
                        elevation: 0, // Remove shadow
                      ),
                      Padding(
                        padding: EdgeInsets.all(16.0),
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
                            // Removed userDetails.login from here
                            SizedBox(height: 4),
                            if (userDetails.name != null)
                              Text(
                                userDetails.name!,
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white, // Text color
                                ),
                              ),
                            SizedBox(height: 16),
                            // Row with Icons and Text
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                _buildStatItem(Icons.folder, "Repositories", userDetails.publicRepos.toString()),
                                _buildStatItem(Icons.group, "Followers", userDetails.followers.toString()),
                                _buildStatItem(Icons.person_add, "Following", userDetails.following.toString()),
                              ],
                            ),

                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Card(
                            elevation: 4, // You can adjust the elevation to make the card more or less prominent
                            margin: EdgeInsets.all(8), // Margin around the card
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5), // You can adjust the corner radius
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(16), // Padding inside the card
                              child: userDetails.bio != null
                                  ? Text(
                                userDetails.bio!,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                                textAlign: TextAlign.center,
                              )
                                  : SizedBox.shrink(), // Use SizedBox.shrink() if bio is null to avoid rendering an empty space
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
                                  onTap: () => _launchURL(userDetails.htmlUrl),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }

  Widget _buildStatItem(IconData icon, String label, String value) {
    return Column(
      children: [
        Icon(icon, size: 24, color: Colors.white), // Icon color
        SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white, // Text color
          ),
        ),
        SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            color: Colors.white, // Text color
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
