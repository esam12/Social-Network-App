import 'package:dartz/dartz.dart';
import 'package:social_network_app/core/errors/failures.dart';
import 'package:social_network_app/core/services/data_service.dart';
import 'package:social_network_app/core/utils/backend_endpoint.dart';
import 'package:social_network_app/features/auth/data/model/user_model.dart';
import 'package:social_network_app/features/auth/domain/entity/user_entity.dart';
import 'package:social_network_app/features/profile/domain/repository/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final DatabaseService _dbService;

  ProfileRepositoryImpl(this._dbService);
  @override
  Future<Either<Failure, UserEntity>> getUserById(String id) async {
    try {
      var userData = await _dbService.getData(
        path: BackendEndpoint.getUsersData,
        documentId: id,
      );
      return right(UserModel.fromSnapshot(userData));
    } on Exception catch (e) {
      return left(ServerFailure("Failed to fetch user: ${e.toString()}"));
    }
  }

  @override
  Future<Either<Failure, void>> updateUser(UserEntity user) async {
    try {
      await _dbService.updateData(
        path: BackendEndpoint.getUsersData,
        documentId: user.id,
        data: user.toMap(),
      );
      return right(null);
    } on Exception catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }
}
