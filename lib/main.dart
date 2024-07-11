import 'package:flutter/material.dart';
import 'home.dart';
import 'splash.dart';
import 'user_list.dart';
import 'user_details.dart';
import 'github_user.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GITHUB USERS APP',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => SplashScreen(),
        '/home': (context) => Homepage(),
        '/userList': (context) => Builder(
          builder: (context) {
            final args = ModalRoute.of(context)!.settings.arguments as String;
            return UserList(context, args);
          },
        ),
        '/userDetails': (context) => Builder(
          builder: (context) {
            final args = ModalRoute.of(context)!.settings.arguments as GitHubUser;
            return UserDetails(user: args);
          },
        ),
      },
    );
  }
}
