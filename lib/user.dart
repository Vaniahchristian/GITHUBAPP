

class User {
  final String login;
  final String avatarUrl;
  final String htmlUrl;

  User({required this.login, required this.avatarUrl, required this.htmlUrl});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      login: json['login'],
      avatarUrl: json['avatar_url'],
      htmlUrl: json['html_url'],
    );
  }
}

class UserDetail {
  final String login;
  final String avatarUrl;
  final String htmlUrl;
  final String name;
  final String bio;

  UserDetail({required this.login, required this.avatarUrl, required this.htmlUrl, required this.name, required this.bio});

  factory UserDetail.fromJson(Map<String, dynamic> json) {
    return UserDetail(
      login: json['login'],
      avatarUrl: json['avatar_url'],
      htmlUrl: json['html_url'],
      name: json['name'],
      bio: json['bio'],
    );
  }
}
