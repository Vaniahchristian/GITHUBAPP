


import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
//import 'package:share/share.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../domain/entities/gitHub_user_detail_entity.dart';
import '../../domain/entities/github_user_entity.dart';
import '../providers/user_details_provider.dart';
import '../widgets/build_info_row.dart';
import '../widgets/build_stat_column.dart';

class UserDetails extends StatelessWidget {
  final GitHubUserEntity user;

  const UserDetails({super.key, required this.user});

  void _shareProfile(GitHubUserDetailEntity user) {
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

  void _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 60,
        title: Text(
          user.login,
          style: const TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          Consumer<UserDetailsProvider>(
            builder: (context, provider, child) {
              //if (provider.isLoading) {
                //return CircularProgressIndicator();
              //} else if (provider.userDetails != null) {
                return IconButton(
                  icon: const Icon(Icons.share),
                  onPressed: () => _shareProfile(provider.userDetails!),
                  color: Colors.white,
                );
              //} else {
                return const SizedBox.shrink();
              //}
            },
          ),
        ],
        backgroundColor: const Color(0xFF36827F),
      ),
      body: FutureBuilder(
        future: Provider.of<UserDetailsProvider>(context, listen: false).fetchUserDetails(user.login),
        builder: (context, snapshot) {
          return Consumer<UserDetailsProvider>(
            builder: (context, provider, child) {
              if (provider.isLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (provider.error != null) {
                return Center(child: Text(provider.error!));
              } else if (provider.userDetails != null) {
                final userDetails = provider.userDetails!;
                return Padding(
                  padding: const EdgeInsets.all(16.0),
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
                        const SizedBox(height: 10),
                        const SizedBox(height: 20),
                        if (userDetails.name != null)
                          Text(
                            userDetails.name!,
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey[700],
                            ),
                          ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            StatColumnWidget(label: "Repositories", value: userDetails.publicRepos.toString()),
                            StatColumnWidget(label: "Followers", value: userDetails.followers.toString()),
                            StatColumnWidget(label: "Following", value: userDetails.following.toString()),
                          ],
                        ),
                        const Divider(),
                        const SizedBox(height: 8),
                        if (userDetails.bio != null)
                          Text(
                            userDetails.bio!,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        const SizedBox(height: 16),
                        InfoRowWidget(icon: Icons.location_on, info: userDetails.location),
                        InfoRowWidget(icon: Icons.email, info: userDetails.email),
                        InfoRowWidget(icon: Icons.business, info: userDetails.company),
                        InfoRowWidget(icon: Icons.description, info: userDetails.blog),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            const Icon(Icons.link, color: Color(0xFF36827F)),
                            const SizedBox(width: 8),
                            Expanded(
                              child: InkWell(
                                child: Text(
                                  userDetails.htmlUrl,
                                  style: const TextStyle(fontSize: 16, color: Colors.blue),
                                ),
                                onTap: () {
                                  _launchURL(userDetails.htmlUrl);
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
                return const Center(child: Text("No user details available."));
              }
            },
          );
        },
      ),
    );
  }
}
