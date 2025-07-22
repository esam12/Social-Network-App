import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:social_network_app/core/errors/failures.dart';
import 'package:social_network_app/features/meet/domain/entity/meet_entity.dart';

abstract class MeetRepository {
  Future<Either<Failure, List<MeetEntity>>> getLastMeets({
    int? page,
    int? limit,
  });

  Future<Either<Failure, void>> createMeet({
    required String title,
    required String description,
    required TimeOfDay time,
    required LatLng location,
  });
}
