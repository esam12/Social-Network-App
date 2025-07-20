import 'package:dartz/dartz.dart';
import 'package:social_network_app/core/errors/failures.dart';
import 'package:social_network_app/features/meet/domain/entity/meet_entity.dart';

abstract class MeetRepository {
  Future<Either<Failure, List<MeetEntity>>> getLastMeets({
    int? page,
    int? limit,
  });
}
