import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_animations/flutter_map_animations.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:topomapper/main.dart';
import 'package:topomapper/map_page/hut_markers_widget.dart';
import 'package:topomapper/map_page/mapbox_attribution_widget.dart';
import 'package:topomapper/models/hut.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key, required this.huts});
  final List<Hut> huts;

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> with TickerProviderStateMixin {
  late final animatedMapController = AnimatedMapController(
    vsync: this,
    duration: const Duration(milliseconds: 1000), 
    curve: Curves.easeInOut
  );

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FlutterMap(
          mapController: animatedMapController.mapController,

          options: const MapOptions(
            maxZoom: 22,
            initialCenter: LatLng(-36.9, 174.7),
            initialZoom: 15,
            interactionOptions: InteractionOptions(
              flags: InteractiveFlag.pinchZoom 
                   | InteractiveFlag.drag 
                   | InteractiveFlag.flingAnimation 
                   | InteractiveFlag.doubleTapDragZoom 
                   | InteractiveFlag.doubleTapZoom
            ),
          ),
          
          children: [
            TileLayer(
              // urlTemplate: 'https://api.mapbox.com/styles/v1/derekchai/clswvy9s0002x01pt8pj307f0/tiles/256/{z}/{x}/{y}@2x?access_token=${dotenv.env['MAPBOX_ACCESS_TOKEN']}',
              urlTemplate: 'https://tiles-cdn.koordinates.com/services;key=${dotenv.env['LINZ_DATA_SERVICE_API_KEY']}/tiles/v4/layer=50767/EPSG:3857/{z}/{x}/{y}.png',
            ),
        
            const MapboxAttributionWidget(),
        
            CurrentLocationLayer(),
        
            HutMarkersWidget(huts: widget.huts)
          ],
        ),


        Positioned(
          right: 1,
          child: SafeArea(
            child: FloatingActionButton.small(
              onPressed: () async {
                var currentPosition = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.bestForNavigation);
                animatedMapController.animateTo(
                  dest: LatLng(currentPosition.latitude, currentPosition.longitude), 
                  zoom: 14
                );
              },
              child: const Icon(Icons.navigation),
            ),
          ),
        )
      ]
    );
  }
}