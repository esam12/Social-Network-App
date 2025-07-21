import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:social_network_app/core/common/widgets/circular_image.dart';
import 'package:social_network_app/core/common/widgets/default_modal_bottom_sheet.dart';
import 'package:social_network_app/core/services/get_it.dart';
import 'package:social_network_app/features/auth/presentation/manager/user_bloc/user_bloc.dart';
import 'package:social_network_app/features/auth/presentation/manager/user_bloc/user_event.dart';
import 'package:social_network_app/features/auth/presentation/manager/user_bloc/user_state.dart';
import 'package:social_network_app/features/create_meet/presentation/page/create_meet_page.dart';
import 'package:social_network_app/features/profile/presentation/manager/last_meets/last_meets_boc.dart';
import 'package:social_network_app/features/profile/presentation/manager/last_meets/last_meets_events.dart';
import 'package:social_network_app/features/profile/presentation/page/edit_profile_page.dart';
import 'package:social_network_app/features/profile/presentation/page/widgets/last_meets_section.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  static const routeName = '/profile';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<LastMeetsBoc>()..add(GetLastMeetsEvent(refresh: true)),
      child: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'Profile',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                ),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return DefaultModalBottomSheet(
                          elements: [
                            ListTile(
                              leading: Icon(
                                Icons.edit,
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                              title: Text('Edit Profile'),
                              onTap: () {
                                context.push(EditProfilePage.routeName);
                              },
                            ),
                            ListTile(
                              leading: Icon(
                                Icons.logout,
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                              title: Text(
                                'Sign Out',
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.error,
                                ),
                              ),
                              onTap: () {
                                context.read<UserBloc>().add(SignOutEvent());
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  icon: Icon(
                    Icons.more_vert,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ],
            ),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SCircularImage(
                          width: 100,
                          height: 100,
                          image: state.userEntity?.avatar ?? '',
                          boxFit: BoxFit.cover,
                          padding: 0,
                          isNetworkImage: state.userEntity?.avatar != null
                              ? true
                              : false,
                        ),

                        SizedBox(width: 15),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${state.userEntity?.name}',
                              style: Theme.of(context).textTheme.bodySmall
                                  ?.copyWith(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                  ),
                            ),
                            Text(
                              '${state.userEntity?.email}',
                              style: Theme.of(context).textTheme.bodySmall
                                  ?.copyWith(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurface
                                        .withValues(alpha: 0.7),
                                  ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Text(
                      state.userEntity?.bio ?? '',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: Theme.of(
                          context,
                        ).colorScheme.onSurface.withValues(alpha: 0.7),
                      ),
                    ),

                    SizedBox(height: 20),
                    InkWell(
                      onTap: () => context.push(CreateMeetPage.routeName),
                      child: Text(
                        'Last Meets',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    ),
                    SizedBox(height: 10),
                    LastMeetsSection(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
