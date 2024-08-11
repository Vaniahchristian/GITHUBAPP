import 'package:flutter/material.dart';
import 'package:githubapp/presentation/providers/filter_provider.dart';
import 'package:githubapp/presentation/providers/user_details_provider.dart';
import 'package:githubapp/presentation/providers/user_provider.dart';
import 'package:githubapp/presentation/screens/home.dart';
import 'package:githubapp/presentation/screens/splash.dart';
import 'package:githubapp/presentation/screens/user_details.dart';
import 'package:provider/provider.dart';

import 'data/datasource/remote_data_source/github_service.dart';
import 'data/repository/github_repository_impl.dart';
import 'domain/entities/github_user_entity.dart';
import 'domain/usecases/fetch_user_details.dart';
import 'domain/usecases/filter_users_usecase.dart';
import 'domain/usecases/github_users_usecase.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final githubService = GitHubService();
    final githubRepository = GitHubRepositoryImpl(githubService);

    // Instantiate use cases
    final fetchUsersByLocationUsecase = FetchUsersByLocationUsecase(githubRepository);
    final fetchUserDetailsUsecase = FetchUserDetailsUsecase(githubRepository);
    final filterUsersUsecase = FilterUsersUsecase(githubRepository);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => UserProvider(fetchUsersByLocationUsecase),
        ),
        ChangeNotifierProvider(
          create: (context) => UserDetailsProvider(fetchUserDetailsUsecase),
        ),
        ChangeNotifierProvider(
          create: (context) => FilterProvider(filterUsersUsecase),
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
