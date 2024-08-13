import 'package:get_it/get_it.dart';
import 'package:githubapp/data/datasource/remote_data_source/github_service.dart';
import 'package:githubapp/data/repository/github_repository_impl.dart';
import 'package:githubapp/domain/repositories/github_repository.dart';
import 'package:githubapp/domain/usecases/fetch_user_details.dart';
import 'package:githubapp/domain/usecases/filter_users_usecase.dart';
import 'package:githubapp/domain/usecases/github_users_usecase.dart';
import 'package:githubapp/presentation/providers/filter_provider.dart';
import 'package:githubapp/presentation/providers/user_details_provider.dart';
import 'package:githubapp/presentation/providers/user_provider.dart';

final sl = GetIt.instance;

void init() {
  // Register the GitHubService
  sl.registerLazySingleton<GitHubService>(() => GitHubService());

  // Register the GitHubRepository interface with its implementation
  sl.registerLazySingleton<GitHubRepository>(
        () => GitHubRepositoryImpl(),
  );

  // Register UseCases
  sl.registerLazySingleton(() => FetchUsersByLocationUsecase());
  sl.registerLazySingleton(() => FetchUserDetailsUsecase());
  sl.registerLazySingleton(() => FilterUsersUsecase());

  // Register Providers
  sl.registerFactory(() => UserProvider());
  sl.registerFactory(() => UserDetailsProvider());
  sl.registerFactory(() => FilterProvider());
}
