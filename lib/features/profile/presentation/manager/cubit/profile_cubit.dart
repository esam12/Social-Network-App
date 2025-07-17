import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_network_app/features/auth/domain/entity/user_entity.dart';
import 'package:social_network_app/features/profile/domain/repository/profile_repository.dart';
import 'package:social_network_app/features/profile/presentation/manager/cubit/profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepository repository;
  // final FirebaseStorageService storage;

  ProfileCubit({required this.repository}) : super(ProfileState.initial());

  void loadUser(UserEntity u) {
    emit(
      state.copyWith(user: u, imageFile: null, status: ProfileStatus.initial),
    );
  }

  Future<void> pickImage() async {
    try {
      final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (picked != null) {
        emit(state.copyWith(imageFile: XFile(picked.path)));
      }
    } catch (_) {
      emit(state.copyWith(errorMessage: 'Failed to pick image'));
    }
  }

  void updateName(String name) =>
      emit(state.copyWith(user: state.user.copyWith(name: name)));

  void updateBio(String bio) =>
      emit(state.copyWith(user: state.user.copyWith(bio: bio)));

  Future<void> saveChanges(UserEntity user) async {
    emit(state.copyWith(status: ProfileStatus.loading, errorMessage: null));

    // final localImg = state.imageFile;
    // String? avatarUrl = state.user.avatar;

    // if (localImg != null) {
    //   avatarUrl = await storage.(state.user.id, localImg);
    // }

    // final updated = state.user.copyWith(
    //   bio: state.user.bio,
    //   name: state.user.name,
    // );
    log(user.toString());

    final res = await repository.updateUser(user);
    res.fold(
      (f) => emit(
        state.copyWith(status: ProfileStatus.error, errorMessage: f.message),
      ),
      (_) => emit(state.copyWith(status: ProfileStatus.success, user: user)),
    );
  }
}
