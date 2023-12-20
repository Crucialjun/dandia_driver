import 'dart:async';

import 'package:dandia_driver/core/constants/app_assets.dart';
import 'package:dandia_driver/features/home/presentation/bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeView extends StatefulWidget {
  static const routeName = '/home-view';
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String? mapStyle;

  @override
  void initState() {
    DefaultAssetBundle.of(context)
        .loadString(AppAssets.darkMapStyle)
        .then((string) {
      mapStyle = string;
    }).catchError((error) {});
    context.read<HomeBloc>().add(HomeInitEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Completer<GoogleMapController> mapController =
        Completer<GoogleMapController>();

    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is HomeLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is HomeLoaded) {
          return Scaffold(
              appBar: AppBar(
                title: const Text('HomeView'),
              ),
              body: Stack(children: [
                GoogleMap(
                  mapType: MapType.normal,
                  myLocationButtonEnabled: true,
                  initialCameraPosition: CameraPosition(
                    target: LatLng(state.locationData.latitude,
                        state.locationData.longitude),
                    zoom: 14.4746,
                  ),
                  onMapCreated: (GoogleMapController controller) {
                    mapController.complete(controller);
                    controller.setMapStyle(mapStyle);
                  },
                ),
              ]));
        }
        return Scaffold(
          body: Center(child: Text(state.toString())),
        );
      },
    );
  }
}
