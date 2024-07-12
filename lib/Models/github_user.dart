class GitHubUser {
  final String login;
  final String avatarUrl;
  final String htmlUrl;
  final String? name;
  final String? location;
  final int? publicRepos;
  final int? followers;
  final int? following;
  final String? bio;
  final String? email;
  final String? company;
  final String? blog;

  GitHubUser({
    required this.login,
    required this.avatarUrl,
    required this.htmlUrl,
    this.name,
    this.location,
    this.publicRepos,
    this.followers,
    this.following,
    this.bio,
    this.email,
    this.company,
    this.blog,
  });

  factory GitHubUser.fromJson(Map<String, dynamic> json) {
    return GitHubUser(
      login: json['login'],
      avatarUrl: json['avatar_url'],
      htmlUrl: json['html_url'],
      name: json['name'],
      location: json['location'],
      publicRepos: json['public_repos'],
      followers: json['followers'],
      following: json['following'],
      bio: json['bio'],
      email: json['email'],
      company: json['company'],
      blog: json['blog'],
    );
  }
}
