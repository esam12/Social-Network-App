import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:social_network_app/core/api/api_client.dart';
import 'package:social_network_app/features/auth/data/datasource/auth_remote_datasource.dart';
import 'package:social_network_app/features/auth/data/repository/auth_repository_impl.dart';
import 'package:social_network_app/features/auth/domain/repository/auth_repository.dart';
import 'package:social_network_app/features/auth/presentation/manager/user_bloc/user_bloc.dart';

var getIt = GetIt.instance;

void setupGetIt() {
  // Register google sign in
  registerGoogleSignIn();
  // Register api client
  registerApiClient();
  // Register data sources
  registerDataSources();
  // Register repositories
  registerRepositories();
  // Register User bloc
  registerUserBloc();
}

void registerGoogleSignIn() {
  getIt.registerSingleton<GoogleSignIn>(GoogleSignIn());
}

void registerApiClient() {
  getIt.registerSingleton(ApiClient());
}

void registerDataSources() {
  var dio = getIt<ApiClient>().getDio();
  var dioWithToken = getIt<ApiClient>().getDio(tokenInterceptor: true);
  getIt.registerSingleton<AuthRemoteDatasource>(AuthRemoteDatasource(dio: dio));
}

void registerRepositories() {
  getIt.registerSingleton<AuthRepository>(
    AuthRepositoryImpl(authRemoteDatasource: getIt(), googleSignIn: getIt()),
  );
}

void registerUserBloc() {
  getIt.registerFactory<UserBloc>(() => UserBloc(authRepository: getIt()));
}
