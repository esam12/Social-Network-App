import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_network_app/core/common/widgets/circular_image.dart';
import 'package:social_network_app/core/common/widgets/default_button.dart';
import 'package:social_network_app/core/common/widgets/default_text_form_field.dart';
import 'package:social_network_app/features/auth/domain/entity/user_entity.dart';
import 'package:social_network_app/features/auth/presentation/manager/user_bloc/user_bloc.dart';
import 'package:social_network_app/features/profile/presentation/manager/cubit/profile_cubit.dart';
import 'package:social_network_app/features/profile/presentation/manager/cubit/profile_state.dart';

class EditProfilePageBody extends StatefulWidget {
  const EditProfilePageBody({super.key});

  @override
  State<EditProfilePageBody> createState() => _EditProfilePageBodyState();
}

class _EditProfilePageBodyState extends State<EditProfilePageBody> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();

  late UserEntity user;

  @override
  void initState() {
    super.initState();
    user = context.read<UserBloc>().state.userEntity!;
    _nameController.text = user.name;
    _bioController.text = user.bio ?? '';
  }

  @override
  void dispose() {
    _nameController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Profile')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Column(
              children: [
                SCircularImage(
                  image: user.avatar!,
                  width: 100,
                  height: 100,
                  isNetworkImage: user.avatar != null ? true : false,
                ),
                // TextButton(
                //   onPressed: () {
                //     context.read<ProfileCubit>().pickImage();
                //   },
                //   child: const Text('Change Profile Picture'),
                // ),
              ],
            ),
            const SizedBox(height: 20),
            DefaultTextFormField(
              controller: _nameController,
              hintText: 'Name',

              // onChanged: (v) =>
              //     context.read<ProfileCubit>().updateName(v),
            ),
            const SizedBox(height: 20),
            DefaultTextFormField(
              controller: _bioController,
              hintText: 'Bio',
              maxLines: 3,
              // onChanged: (v) => context.read<ProfileCubit>().updateBio(v),
            ),
            const Spacer(),
            BlocBuilder<ProfileCubit, ProfileState>(
              builder: (context, state) {
                return DefaultButton(
                  title: 'Save',
                  onPressed: () {
                    context.read<ProfileCubit>().saveChanges(
                      user.copyWith(
                        name: _nameController.text,
                        bio: _bioController.text,
                      ),
                    );
                    if (state.status == ProfileStatus.loading) {
                      return const CircularProgressIndicator();
                    }
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
