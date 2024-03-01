
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:latlong2/latlong.dart';
import 'package:topomapper/models/hut.dart';

class HutMarkersWidget extends StatelessWidget {
  const HutMarkersWidget({
    super.key,
    required this.huts,
  });

  final List<Hut> huts;

  @override
  Widget build(BuildContext context) {
    return MarkerClusterLayerWidget(
      options: MarkerClusterLayerOptions(
        maxClusterRadius: 100,
        size: const Size(40, 40),
        markers: huts.map(
          (e) => Marker(
            width: 15,
            height: 15,
            point: LatLng(e.lat, e.lon), 
            child: const FlutterLogo()
          )
        ).toList(),
    
        builder: (context, markers) {
          return Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.blue),
            child: Center(
              child: Text(
                markers.length.toString(),
                style: const TextStyle(color: Colors.white),
              ),
            ),
          );
        }
      ),
    );
  }
}