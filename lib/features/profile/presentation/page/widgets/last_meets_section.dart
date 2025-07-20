import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_network_app/features/profile/presentation/manager/last_meets/last_meets_boc.dart';
import 'package:social_network_app/features/profile/presentation/manager/last_meets/last_meets_state.dart';

class LastMeetsSection extends StatelessWidget {
  const LastMeetsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LastMeetsBoc, LastMeetsState>(
      builder: (context, state) {
        return ListView.builder(
          itemCount: 3,
          shrinkWrap: true,
          itemBuilder: (context, index) {},
        );
      },
    );
  }
}
