import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:social_network_app/core/common/widgets/default_button.dart';
import 'package:social_network_app/core/common/widgets/default_text_form_field.dart';
import 'package:social_network_app/features/create_meet/presentation/page/location_picker_page.dart';

class CreateMeetPage extends StatefulWidget {
  const CreateMeetPage({super.key});

  static const routeName = '/create-meet';

  @override
  State<CreateMeetPage> createState() => _CreateMeetPageState();
}

class _CreateMeetPageState extends State<CreateMeetPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  GoogleMapController? _mapController;
  TimeOfDay timeOfDay = TimeOfDay.now();
  LatLng? location;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _mapController?.dispose();  
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Create Meet',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Title',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 10),
                DefaultTextFormField(
                  hintText: "Enter meet title",
                  controller: _titleController,
                ),

                SizedBox(height: 15),
                Text(
                  'Description',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 10),
                DefaultTextFormField(
                  hintText: "Enter meet description",
                  controller: _descriptionController,
                  maxLength: 255,
                  minLines: 2,
                  maxLines: 6,
                ),

                SizedBox(height: 15),

                Text(
                  "Time",
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 5.0),
                Text(
                  "Events automatically mark as completed 2 hours after that start.",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 12,
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withValues(alpha: 0.7),
                  ),
                ),
                SizedBox(height: 10),
                _buildTimePicker(context),
                SizedBox(height: 15),
                Text(
                  "Location",
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  "Tap map to select location",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 12,
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withValues(alpha: 0.7),
                  ),
                ),
                SizedBox(height: 10),
                _buildLocationPicker(),
                SizedBox(height: 10),
                DefaultButton(title: 'Create Meet', onPressed: () {}),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTimePicker(BuildContext context) {
    return Row(
      children: [
        _buildTimePart(context, timeOfDay.hour),
        SizedBox(width: 5),
        Text(':', style: Theme.of(context).textTheme.bodyMedium),
        SizedBox(width: 5),
        _buildTimePart(context, timeOfDay.minute),
      ],
    );
  }

  Widget _buildTimePart(BuildContext context, int value) {
    return InkWell(
      onTap: () async {
        var time = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
          initialEntryMode: TimePickerEntryMode.inputOnly,
        );

        if (time != null) {
          setState(() {
            timeOfDay = time;
          });
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: EdgeInsets.all(12),
        child: Text(
          value.toString().padLeft(2, '0'),
          style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 16),
        ),
      ),
    );
  }

  Widget _buildLocationPicker() {
    return Container(
      height: 300,
      width: double.maxFinite,

      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
      child: GoogleMap(
        myLocationEnabled: false,
        compassEnabled: false,
        myLocationButtonEnabled: false,
        scrollGesturesEnabled: false,
        zoomControlsEnabled: false,
        zoomGesturesEnabled: false,
        tiltGesturesEnabled: false,
        rotateGesturesEnabled: false,
        onMapCreated: (controller) {
          setState(() {
            _mapController = controller;
          });
        },
        onTap: (argument) async {
          LatLng? selectedLocation = await context.push(
            LocationPickerPage.routeName,
          );

          if (selectedLocation != null) {
            setState(() {
              location = selectedLocation;
            });

            _mapController?.animateCamera(
              CameraUpdate.newLatLngZoom(selectedLocation, 16),
            );
          }
        },
        markers: location != null
            ? {
                Marker(
                  markerId: MarkerId('selectedLocation'),
                  position: location!,
                ),
              }
            : {},

        initialCameraPosition: CameraPosition(
          target: LatLng(36.542841, 36.150188),
          zoom: 10,
        ),
      ),
    );
  }
}
