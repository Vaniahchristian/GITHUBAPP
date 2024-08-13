import 'package:flutter/material.dart';
import 'package:githubapp/presentation/providers/filter_provider.dart';
import 'package:githubapp/presentation/providers/user_details_provider.dart';
import 'package:githubapp/presentation/providers/user_provider.dart';
import 'package:githubapp/presentation/screens/home.dart';
import 'package:githubapp/presentation/screens/splash.dart';
import 'package:githubapp/presentation/screens/user_details.dart';
import 'package:provider/provider.dart';
import 'injector.dart';
import 'domain/entities/github_user_entity.dart';

void main() {
  // Initialize the injector
  init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => sl<UserProvider>(),
        ),
        ChangeNotifierProvider(
          create: (context) => sl<UserDetailsProvider>(),
        ),
        ChangeNotifierProvider(
          create: (context) => sl<FilterProvider>(),
        ),
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
          '/splash': (context) => const SplashScreen(),
          '/home': (context) => const Homepage(),
          '/userDetails': (context) => Builder(
            builder: (context) {
              final args = ModalRoute.of(context)!.settings.arguments as GitHubUserEntity;
              return UserDetails(user: args);
            },
          ),
        },
      ),
    );
  }
}
