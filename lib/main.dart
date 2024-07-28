import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:githubapp/Data/Models/github_user_model.dart';
import 'package:githubapp/Providers/user_provider.dart';

import 'Presentation/Screens/home.dart';
import 'Presentation/Screens/splash.dart';
import 'Presentation/Screens/user_details.dart';
import 'Providers/UserDetailsProvider.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => UserProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => UserDetailsProvider(),
        ),
        // Add other providers here if needed
      ],
      child: MaterialApp(
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
              final args = ModalRoute.of(context)!.settings.arguments as GitHubUserModel;
              return UserDetails(user: args);
            },
          ),
        },
      ),
    );
  }
}
