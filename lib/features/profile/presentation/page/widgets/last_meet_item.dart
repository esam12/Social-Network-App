import 'package:flutter/material.dart';
import 'package:social_network_app/core/common/widgets/circular_image.dart';
import 'package:social_network_app/features/meet/domain/entity/meet_entity.dart';

class LastMeetItem extends StatelessWidget {
  final MeetEntity meet;
  const LastMeetItem({super.key, required this.meet});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onSurfaceVariant,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            meet.title,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(width: 8),
          Text(
            '${meet.date.hour}:${meet.date.minute}',
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(fontSize: 16),
          ),

          Spacer(),

          ...meet.attendees.map(
            (e) => Padding(
              padding: EdgeInsets.only(left: 4),
              child: SCircularImage(width: 30, height: 30, image: e.avatar!),
            ),
          ),
        ],
      ),
    );
  }
}
