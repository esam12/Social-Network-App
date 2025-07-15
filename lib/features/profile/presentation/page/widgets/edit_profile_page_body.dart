import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_network_app/core/common/widgets/circular_image.dart';
import 'package:social_network_app/core/common/widgets/default_button.dart';
import 'package:social_network_app/core/common/widgets/default_text_form_field.dart';
import 'package:social_network_app/core/theme/app_images.dart';
import 'package:social_network_app/features/auth/presentation/manager/user_bloc/user_bloc.dart';
import 'package:social_network_app/features/profile/presentation/manager/cubit/profile_cubit.dart';
import 'package:social_network_app/features/profile/presentation/manager/cubit/profile_state.dart';

class EditProfilePageBody extends StatefulWidget {
  const EditProfilePageBody({super.key});

  @override
  State<EditProfilePageBody> createState() => _EditProfilePageBodyState();
}

class _EditProfilePageBodyState extends State<EditProfilePageBody> {
  final _nameCtrl = TextEditingController();
  final _bioCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final u = context.read<UserBloc>().state.userEntity!;
      _nameCtrl.text = u.name;
      _bioCtrl.text = u.bio ?? '';
      context.read<ProfileCubit>().loadUser(u);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Profile')),
      body: BlocListener<ProfileCubit, ProfileState>(
        listener: (c, s) {
          if (s.status == ProfileStatus.success) {
            ScaffoldMessenger.of(
              c,
            ).showSnackBar(const SnackBar(content: Text('Profile updated')));
            Navigator.pop(context);
          } else if (s.status == ProfileStatus.error) {
            ScaffoldMessenger.of(
              c,
            ).showSnackBar(SnackBar(content: Text(s.errorMessage!)));
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              BlocBuilder<ProfileCubit, ProfileState>(
                builder: (c, s) {
                  final local = s.imageFile;
                  final url = context.read<UserBloc>().state.userEntity?.avatar;

                  ImageProvider provider;
                  if (local != null) {
                    provider = FileImage(local);
                  } else if (url != null && url.startsWith('http')) {
                    provider = CachedNetworkImageProvider(url);
                  } else {
                    provider = const AssetImage(SImages.user);
                  }

                  return SCircularImage(
                    image: provider,
                    width: 100,
                    height: 100,
                  );
                },
              ),
              DefaultTextFormField(
                controller: _nameCtrl,
                hintText: 'Name',
                onChanged: (v) => context.read<ProfileCubit>().updateName(v),
              ),
              DefaultTextFormField(
                controller: _bioCtrl,
                hintText: 'Bio',
                maxLines: 3,
                onChanged: (v) => context.read<ProfileCubit>().updateBio(v),
              ),
              const Spacer(),
              BlocBuilder<ProfileCubit, ProfileState>(
                builder: (c, s) {
                  return DefaultButton(
                    title: s.status == ProfileStatus.loading
                        ? 'Saving...'
                        : 'Save',
                    onPressed: s.status == ProfileStatus.loading
                        ? null
                        : () => context.read<ProfileCubit>().saveChanges(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _bioCtrl.dispose();
    super.dispose();
  }
}
