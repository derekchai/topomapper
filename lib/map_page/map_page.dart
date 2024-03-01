import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:latlong2/latlong.dart';
import 'package:topomapper/map_page/mapbox_attribution_widget.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  @override
  Widget build(BuildContext context) {
    const String accessToken = String.fromEnvironment('ACCESS_TOKEN');

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: FlutterMap(
        options: const MapOptions(
          maxZoom: 22,
          initialCenter: LatLng(-36.9, 174.7),
          initialZoom: 15
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://api.mapbox.com/styles/v1/derekchai/clswvy9s0002x01pt8pj307f0/tiles/256/{z}/{x}/{y}@2x?access_token=$accessToken',
          ),
          const MapboxAttributionWidget(),
          CurrentLocationLayer()
        ],
      )
    );
  }
}
