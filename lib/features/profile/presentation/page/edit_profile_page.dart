import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_network_app/core/common/widgets/circular_image.dart';
import 'package:social_network_app/core/common/widgets/default_button.dart';
import 'package:social_network_app/core/common/widgets/default_text_form_field.dart';
import 'package:social_network_app/core/theme/app_colors.dart';
import 'package:social_network_app/core/theme/app_images.dart';
import 'package:social_network_app/features/auth/presentation/manager/user_bloc/user_bloc.dart';
import 'package:social_network_app/features/auth/presentation/manager/user_bloc/user_event.dart';
import 'package:social_network_app/features/auth/presentation/manager/user_bloc/user_state.dart';
import 'package:social_network_app/features/profile/presentation/manager/cubit/image_picker_cubit.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  static const routeName = '/edit-profile';

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();

  @override
  void initState() {
    super.initState();
    var user = context.read<UserBloc>().state.userEntity;
    _nameController.text = user?.name ?? '';
    _bioController.text = user?.bio ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ImagePickerCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Edit Profile',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w500,
              fontSize: 20,
            ),
          ),
        ),
        body: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: BlocBuilder<ImagePickerCubit, ImagePickerState>(
                        builder: (context, imageState) {
                          final pickedImagePath = imageState is ImagePicked
                              ? imageState.imageFile.path
                              : state.userEntity?.avatar ?? SImages.user;

                          final isNetworkImage = imageState is! ImagePicked;
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SCircularImage(
                                image: pickedImagePath,
                                isNetworkImage: isNetworkImage,
                                isFileImage: imageState is ImagePicked,
                                width: 100,
                                height: 100,
                                // isNetworkImage: networkImage.isNotEmpty,
                              ),
                              TextButton(
                                onPressed: () {
                                  context.read<ImagePickerCubit>().pickImage();
                                },
                                child: const Text(
                                  'Change Profile Picture',
                                  style: TextStyle(fontSize: 12),
                                ),
                              ),
                              Divider(color: AppColors.grey),
                              SizedBox(height: 20),
                            ],
                          );
                        },
                      ),
                    ),
                    Text(
                      'Name',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 10),
                    DefaultTextFormField(
                      hintText: 'Enter your name',
                      controller: _nameController,
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Bio',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 10),
                    DefaultTextFormField(
                      hintText: 'Enter your bio',
                      controller: _bioController,
                      minLines: 2,
                      maxLines: 6,
                      maxLength: 256,
                    ),
                    Spacer(),
                    DefaultButton(
                      title: 'Save',
                      onPressed: () {
                        context.read<UserBloc>().add(
                          UpdateUserEvent(
                            userEntity: state.userEntity!.copyWith(
                              name: _nameController.text,
                              bio: _bioController.text,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
