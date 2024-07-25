import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import '../../Data/Models/github_user.dart';
import '../../Providers/details_provider.dart';


class UserDetails extends StatelessWidget {
  final String username;

  UserDetails({required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<DetailsProvider>(
        builder: (context, detailsProvider, child) {
          return FutureBuilder<void>(
            future: detailsProvider.fetchUserDetails(username),
            builder: (context, snapshot) {
              if (detailsProvider.isLoading) {
                return Center(child: CircularProgressIndicator());
              } else if (detailsProvider.errorMessage != null) {
                return Center(child: Text('Error: ${detailsProvider.errorMessage}'));
              } else if (detailsProvider.userDetail == null) {
                return Center(child: Text('No details found'));
              } else {
                final userDetails = detailsProvider.userDetail!;

                return Column(
                  children: [
                    Container(
                      color: Color(0xFF36827F),
                      child: Column(
                        children: [
                          AppBar(
                            toolbarHeight: 60,
                            title: Center(
                              child: Text(
                                userDetails.login,
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            iconTheme: IconThemeData(color: Colors.white),
                            actions: [
                              IconButton(
                                icon: Icon(Icons.share),
                                onPressed: () => _shareProfile(userDetails),
                                color: Colors.white,
                              ),
                            ],
                            backgroundColor: Colors.transparent,
                            elevation: 0,
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
                                if (userDetails.name != null)
                                  Text(
                                    userDetails.name!,
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                    ),
                                  ),
                                SizedBox(height: 16),
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
                      ),
                    ),
                  ],
                );
              }
            },
          );
        },
      ),
    );
  }

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

  Widget _buildStatItem(IconData icon, String label, String value) {
    return Column(
      children: [
        Icon(icon, size: 24, color: Colors.white),
        SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            color: Colors.white,
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
