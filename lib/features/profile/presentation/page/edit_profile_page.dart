import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_network_app/core/services/get_it.dart';
import 'package:social_network_app/features/profile/domain/repository/profile_repository.dart';
import 'package:social_network_app/features/profile/presentation/manager/cubit/profile_cubit.dart';
import 'package:social_network_app/features/profile/presentation/page/widgets/edit_profile_page_body.dart';

class EditProfilePage extends StatelessWidget {
  static const routeName = '/edit-profile';
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return ProfileCubit(
          repository: getIt<ProfileRepository>(),
          // storage: getIt<FirebaseStorageService>(),
        );
      },

      child: const EditProfilePageBody(),
    );
  }
}
