import 'package:flutter/material.dart';
import 'Presentation/Screens/home.dart';
import 'Presentation/Screens/splash.dart';
import 'Presentation/Screens/user_details.dart';
import 'Data/Models/github_user.dart';


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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => SplashScreen(),
        '/home': (context) => Homepage(),


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
