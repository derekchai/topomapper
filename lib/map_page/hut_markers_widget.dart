
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:latlong2/latlong.dart';
import 'package:topomapper/main.dart';
import 'package:topomapper/map_page/hut_detail_dialog.dart';
import 'package:topomapper/models/hut.dart';
import 'package:topomapper/models/hut_detail.dart';

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
            width: 10,
            height: 10,
            point: LatLng(e.lat, e.lon), 
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.blueAccent,
              ),

              child: InkWell(
                onTap: () async {
                  log.i('${e.name} (${e.status})\n${e.region} ${e.assetId}\n${e.lat}, ${e.lon}');

                  await getHutDetailFromDocApi(e.assetId).then((result) {
                    showModalBottomSheet(
                      context: context, 
                      builder: (context) {
                        return HutDetailDialog(hutDetail: result);
                      }
                    );
                  });
                },
              ),
            )
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