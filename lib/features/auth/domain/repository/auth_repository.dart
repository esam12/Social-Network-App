import 'package:social_network_app/core/common/models/either.dart';
import 'package:social_network_app/core/common/models/failure.dart';
import 'package:social_network_app/features/auth/domain/entity/user_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserEntity>> signInWithGoogle();
}
