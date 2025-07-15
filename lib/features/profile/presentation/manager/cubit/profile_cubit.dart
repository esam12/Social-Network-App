import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_network_app/features/auth/domain/entity/user_entity.dart';
import 'package:social_network_app/features/profile/domain/repository/profile_repository.dart';
import 'package:social_network_app/features/profile/presentation/manager/cubit/profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepository repository;

  ProfileCubit({required this.repository}) : super(ProfileState.initial());
  void loadUser(UserEntity u) {
    emit(
      state.copyWith(
        userId: u.id,
        name: u.name,
        bio: u.bio ?? '',
        imageFile: u.avatar != null ? File(u.avatar!) : null,
      ),
    );
  }

  Future<void> pickImage() async {
    final picker = ImagePicker();
    try {
      final file = await picker.pickImage(source: ImageSource.gallery);
      if (file != null) {
        emit(state.copyWith(imageFile: File(file.path)));
      }
    } catch (e) {
      emit(state.copyWith(errorMessage: 'Failed to pick image'));
    }
  }

  void updateName(String name) {
    emit(state.copyWith(name: name));
  }

  void updateBio(String bio) {
    emit(state.copyWith(bio: bio));
  }

  Future<void> saveChanges() async {
    final avatar = state.imageFile?.path;
    final user = UserEntity(
      id: state.userId,
      name: state.name,
      bio: state.bio,
      avatar: avatar,
    );
    emit(state.copyWith(status: ProfileStatus.loading, errorMessage: null));

    final res = await repository.updateUser(user);
    res.fold(
      (f) => emit(
        state.copyWith(status: ProfileStatus.error, errorMessage: f.message),
      ),
      (_) => emit(state.copyWith(status: ProfileStatus.success)),
    );
  }
}
