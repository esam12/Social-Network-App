
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:social_network_app/core/common/widgets/default_button.dart';
import 'package:social_network_app/core/services/get_it.dart';
import 'package:social_network_app/features/create_meet/presentation/manager/location_bloc/location_picker_bloc.dart';
import 'package:social_network_app/features/create_meet/presentation/manager/location_bloc/location_picker_event.dart';
import 'package:social_network_app/features/create_meet/presentation/manager/location_bloc/location_picker_state.dart';

class LocationPickerPage extends StatefulWidget {
  static const routeName = '/location-picker';
  const LocationPickerPage({super.key});

  @override
  State<LocationPickerPage> createState() => _LocationPickerPageState();
}

class _LocationPickerPageState extends State<LocationPickerPage> {
  GoogleMapController? mapController;

  @override
  void dispose() {
    mapController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<LocationPickerBloc>()..add(GetUserLocationEvent()),
      child: BlocConsumer<LocationPickerBloc, LocationPickerState>(
        listener: (context, state) async {
          if (state.status == LocationPickerStatus.success &&
              state.location != null) {
            mapController?.animateCamera(
              CameraUpdate.newCameraPosition(
                CameraPosition(target: state.location!, zoom: 16),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state.status == LocationPickerStatus.loading) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator.adaptive()),
            );
          }
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'Select Location',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            body: Stack(
              children: [
                GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target:
                        state.location ?? const LatLng(36.542841, 36.150188),
                    zoom: 16,
                  ),
                  myLocationEnabled: true,
                  onCameraMove: (camera) {
                    context.read<LocationPickerBloc>().add(
                      SetLocationEvent(camera.target),
                    );
                  },
                  onMapCreated: (controller) {
                    mapController = controller;
                  },
                ),
                Center(
                  child: Icon(
                    Icons.location_pin,
                    color: Theme.of(context).colorScheme.error,
                    size: 35,
                  ),
                ),

                Positioned(
                  bottom: 20,
                  left: 20,
                  right: 20,
                  child: DefaultButton(
                    title: 'Select Location',
                    onPressed: state.location == null
                        ? null
                        : () {
                            context.pop(state.location);
                          },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
