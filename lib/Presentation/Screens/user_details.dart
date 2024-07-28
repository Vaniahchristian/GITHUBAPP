import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import '../../Data/Models/github_user_detail_model.dart';
import '../../Data/Models/github_user_model.dart';
import '../../Providers/UserDetailsProvider.dart';

class UserDetails extends StatelessWidget {
  final GitHubUserModel user;

  UserDetails({required this.user});

  void _shareProfile(GitHubUserDetailModel user) {
    final String text = '''
    GitHub User Profile:
    Username: ${user.login}
    Name: ${user.name}
    Location: ${user.location ?? 'N/A'}
    Public Repositories: ${user.publicRepos}
    Followers: ${user.followers}
    Following: ${user.following}
    Profile URL: ${user.htmlUrl}
    ''';

    Share.share(text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        title: Text(
          user.login,
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        actions: [
          Consumer<UserDetailsProvider>(
            builder: (context, provider, child) {
              if (provider.isLoading) {
                return CircularProgressIndicator();
              } else if (provider.userDetails != null) {
                return IconButton(
                  icon: Icon(Icons.share),
                  onPressed: () => _shareProfile(provider.userDetails!),
                  color: Colors.white,
                );
              } else {
                return SizedBox.shrink();
              }
            },
          ),
        ],
        backgroundColor: Color(0xFF000080),
      ),
      body: FutureBuilder(
        future: Provider.of<UserDetailsProvider>(context, listen: false).fetchUserDetails(user.login),
        builder: (context, snapshot) {
          return Consumer<UserDetailsProvider>(
            builder: (context, provider, child) {
              if (provider.isLoading) {
                return Center(child: CircularProgressIndicator());
              } else if (provider.error != null) {
                return Center(child: Text(provider.error!));
              } else if (provider.userDetails != null) {
                final userDetails = provider.userDetails!;
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
              } else {
                return Center(child: Text("No user details available."));
              }
            },
          );
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
    if (info == null || info.isEmpty) {
      return SizedBox.shrink();
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
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
