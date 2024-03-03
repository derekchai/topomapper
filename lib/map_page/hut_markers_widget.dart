
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_animations/flutter_map_animations.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:latlong2/latlong.dart';
import 'package:topomapper/main.dart';
import 'package:topomapper/map_page/basic_hut_detail_dialog.dart';
import 'package:topomapper/map_page/hut_detail_dialog.dart';
import 'package:topomapper/models/hut.dart';
import 'package:topomapper/models/hut_detail.dart';

class HutMarkersWidget extends StatelessWidget {
  const HutMarkersWidget({
    super.key,
    required this.huts,
    required this.controller
  });

  final List<Hut> huts;
  final AnimatedMapController controller;

  @override
  Widget build(BuildContext context) {
    return MarkerClusterLayerWidget(
      options: MarkerClusterLayerOptions(
        maxClusterRadius: 100,
        size: const Size(40, 40),

        markers: huts.map(
          (e) => Marker(
            width: 18,
            height: 18,
            point: LatLng(e.lat, e.lon), 

            child: InkWell(
              onTap: () async {
                log.i('${e.name} (${e.status})\n${e.region} ${e.assetId}\n${e.lat}, ${e.lon}');

                controller.animateTo(dest: LatLng(e.lat - 0.1, e.lon));
            
                await getHutDetailFromDocApi(e.assetId).then((result) {
                  if (result != null) {
                    showModalBottomSheet(
                      isScrollControlled: true,
                      isDismissible: true,
                      context: context, 
                      builder: (context) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: HutDetailDialog(hutDetail: result),
                        );
                      }
                    );
                  } else {
                    showModalBottomSheet(
                      isScrollControlled: true,
                      isDismissible: true,
                      context: context, 
                      builder: (context) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: BasicHutDetailDialog(hut: e),
                        );
                      }
                    );
                  }
                });
              },
            
              child: const CircleAvatar(
                backgroundColor: Colors.blue,
                child: Icon(
                  Icons.house,
                  size: 15, 
                  color: Colors.white, 
                ),
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