import 'package:flutter/material.dart';
import 'Screens/home.dart';
import 'Screens/splash.dart';
import 'Screens/user_list.dart';
import 'Screens/user_details.dart';
import 'Models/github_user.dart';


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
