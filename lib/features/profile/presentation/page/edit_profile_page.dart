import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_network_app/core/common/widgets/circular_image.dart';
import 'package:social_network_app/core/theme/app_images.dart';
import 'package:social_network_app/features/auth/presentation/manager/user_bloc/user_bloc.dart';
import 'package:social_network_app/features/auth/presentation/manager/user_bloc/user_state.dart';
import 'package:social_network_app/features/profile/presentation/manager/cubit/image_picker_cubit.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key});

  static const routeName = '/edit-profile';

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
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: BlocBuilder<ImagePickerCubit, ImagePickerState>(
                      builder: (context, imageState) {

                        final pickedImagePath = imageState is ImagePicked
                            ? imageState.imageFile.path
                            : state.userEntity?.avatar ?? SImages.user;

                        print(pickedImagePath);

                        final isNetworkImage = imageState is! ImagePicked;
                        return Column(
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
                                print('Change Profile Picture');
                                context.read<ImagePickerCubit>().pickImage();
                              },
                              child: const Text('Change Profile Picture'),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
