import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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
      final result = await dbService.getData(
        path: BackendEndpoint.getLastMeets,
        query: {if (limit != null) 'limit': limit},
      );

      final data = (result as List<dynamic>)
          .cast<Map<String, dynamic>>()
          .map(MeetEntity.fromJson)
          .toList();
      log(data.toString());

      return right(data);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> createMeet({
    required String title,
    required String description,
    required TimeOfDay time,
    required LatLng location,
  }) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        return left(ServerFailure("User not logged in"));
      }

      final adminData = {
        'id': user.uid,
        'name': user.displayName ?? '',
        'email': user.email ?? '',
        'avatar': user.photoURL ?? '',
      };
      final docRef = FirebaseFirestore.instance.collection('meets').doc();
    final generatedId = docRef.id;
      return right(
        dbService.addData(
          path: BackendEndpoint.createMeet,
          data: {
            'id': generatedId,
            'title': title,
            'description': description,
            'time': DateTime.now()
                .copyWith(hour: time.hour, minute: time.minute)
                .toUtc()
                .toIso8601String(),
            'latitude': location.latitude,
            'longitude': location.longitude,
            'admin': adminData,
            'attendees': [adminData],
            'isFinished': false,
            'isCancelled': false,
          },
        ),
      );
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }
}
