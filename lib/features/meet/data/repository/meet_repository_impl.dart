import 'package:dartz/dartz.dart';
import 'package:social_network_app/core/errors/failures.dart';
import 'package:social_network_app/core/services/data_service.dart';
import 'package:social_network_app/core/utils/backend_endpoint.dart';
import 'package:social_network_app/features/meet/domain/entity/meet_entity.dart';
import 'package:social_network_app/features/meet/domain/repository/meet_repository.dart';

class MeetRepositoryImpl implements MeetRepository {
  final DatabaseService dbService;

  MeetRepositoryImpl({required this.dbService});

  @override
  Future<Either<Failure, List<MeetEntity>>> getLastMeets({
    int? page,
    int? limit,
  }) async {
    try {
      return right(await dbService.getData( path: BackendEndpoint.getLastMeets, query: {'limit': limit}));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }
}
