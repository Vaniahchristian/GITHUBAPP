import 'package:flutter/material.dart';
import 'Data/Remote_Data_Source/github_service.dart';
import 'Data/Repositories/user_repository_impl.dart';
import 'Domain/usecases/users_usecase.dart';
import 'Presentation/Screens/home.dart';
import 'Presentation/Screens/splash.dart';
import 'Presentation/Screens/user_details.dart';
import 'Data/Models/github_user.dart';
import 'package:provider/provider.dart';

import 'Presentation/Providers/providers.dart';
import 'Providers/user_provider.dart';




void main() {
  final githubService = GitHubService();
  final userRepository = UserRepositoryImpl(githubService: githubService);
  final getUsersByLocation = GetUsersByLocation(userRepository);


  runApp(
    ChangeNotifierProvider(
      create: (context) => UserProvider(getUsersByLocation: getUsersByLocation),
      child: MyApp(),
    ),
  );;
}





class MyApp extends StatelessWidget {

  //final GetUsersByLocation getUsersByLocation;
  //MyApp({required this.getUsersByLocation});

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //return change notifier provider
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
