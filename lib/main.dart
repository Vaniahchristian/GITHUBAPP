import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Data/Remote_Data_Source/github_service.dart';
import 'Data/Repositories/user_details_impl.dart';
import 'Data/Repositories/user_repository_impl.dart';
import 'Domain/usecases/get_user_details_usecase.dart';
import 'Domain/usecases/users_usecase.dart';
import 'Presentation/Screens/home.dart';
import 'Presentation/Screens/splash.dart';
import 'Presentation/Screens/user_details.dart';
import 'Data/Models/github_user.dart';
import 'Providers/details_provider.dart';
import 'Providers/user_provider.dart';

void main() {
  final githubService = GitHubService(); // Data source
  final userRepository = UserRepositoryImpl(githubService: githubService); // For user list
  final getUsersByLocation = GetUsersByLocation(userRepository);

  final detailsRepository = UserDetailsImpl(githubService: githubService); // For profile
  final getUserDetails = GetUserDetailsUsecase(repository: detailsRepository);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DetailsProvider(getUserDetailsUsecase: getUserDetails)),
        ChangeNotifierProvider(create: (_) => UserProvider(getUsersByLocation: getUsersByLocation)),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GitHub Users App',
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
            return UserDetails(username: args.login); // Pass the username to UserDetails
          },
        ),
      },
    );
  }
}
