import 'package:get_it/get_it.dart';
import 'package:social_network_app/core/services/data_service.dart';
import 'package:social_network_app/core/services/firebase_auth_service.dart';
import 'package:social_network_app/core/services/firestore_service.dart';
import 'package:social_network_app/features/auth/data/repository/auth_repository_impl.dart';
import 'package:social_network_app/features/auth/domain/repository/auth_repository.dart';
import 'package:social_network_app/features/auth/presentation/manager/user_bloc/user_bloc.dart';
import 'package:social_network_app/features/meet/data/repository/meet_repository_impl.dart';
import 'package:social_network_app/features/meet/domain/repository/meet_repository.dart';
import 'package:social_network_app/features/profile/data/repository/profile_repository_impl.dart';
import 'package:social_network_app/features/profile/domain/repository/profile_repository.dart';
import 'package:social_network_app/features/profile/presentation/manager/cubit/profile_cubit.dart';
import 'package:social_network_app/features/profile/presentation/manager/last_meets/last_meets_boc.dart';

var getIt = GetIt.instance;

void setupGetIt() {
  getIt.registerSingleton<FirebaseAuthService>(FirebaseAuthService());
  getIt.registerSingleton(FireStoreService());

  registerServices();
  // Register repositories
  registerRepositories();
  // Register User bloc
  registerUserBloc();
}

void registerServices() {
  getIt.registerSingleton<DatabaseService>(FireStoreService());

  // getIt.registerSingleton<CloudStorage>(FirebaseStorageService());
}

void registerRepositories() {
  getIt.registerSingleton<AuthRepository>(AuthRepositoryImpl(getIt(), getIt()));

  getIt.registerSingleton<ProfileRepository>(ProfileRepositoryImpl(getIt()));

  getIt.registerSingleton<MeetRepository>(MeetRepositoryImpl(dbService: getIt()));
}

void registerUserBloc() {
  getIt.registerFactory<UserBloc>(() => UserBloc(authRepository: getIt()));

  getIt.registerFactory<ProfileCubit>(() => ProfileCubit(repository: getIt()));

  getIt.registerFactory(() => LastMeetsBoc(repository: getIt()));
}
