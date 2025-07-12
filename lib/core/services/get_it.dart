import 'package:get_it/get_it.dart';
import 'package:social_network_app/core/services/data_service.dart';
import 'package:social_network_app/core/services/firestore_service.dart';
import 'package:social_network_app/features/auth/data/repository/auth_repository_impl.dart';
import 'package:social_network_app/features/auth/domain/repository/auth_repository.dart';
import 'package:social_network_app/features/auth/presentation/manager/user_bloc/user_bloc.dart';

var getIt = GetIt.instance;

void setupGetIt() {
  registerServices();
  // Register repositories
  registerRepositories();
  // Register User bloc
  registerUserBloc();
}

void registerServices() {
  getIt.registerSingleton<DatabaseService>(FireStoreService());
}

void registerRepositories() {
  getIt.registerSingleton<AuthRepository>(
    AuthRepositoryImpl(firebaseAuthService: getIt(), databaseService: getIt()),
  );
}

void registerUserBloc() {
  getIt.registerFactory<UserBloc>(() => UserBloc(authRepository: getIt()));
}
