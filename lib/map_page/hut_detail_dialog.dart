import 'package:flutter/material.dart';
import 'package:topomapper/models/hut_detail.dart';
import 'package:topomapper/style/project_text.dart';

class HutDetailDialog extends StatelessWidget {
  const HutDetailDialog({super.key, required this.hutDetail});

  final HutDetail hutDetail;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        clipBehavior: Clip.none,
        children: [
          // Circular hut thumbnail.
          Positioned(
            top: -51,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.white,
                image: DecorationImage(
                  image: NetworkImage(hutDetail.introductionThumbnail),
                  fit: BoxFit.cover
                ),
                borderRadius: const BorderRadius.all(Radius.circular(50)),
                border: Border.all(
                  color: Colors.white,
                  width: 4.0
                ),
                boxShadow: const [
                  BoxShadow(
                    blurRadius: 12,
                    spreadRadius: -5
                  )
                ]
              ),
            ),
          ),
      
          // Detail text.
          Positioned(
            top: 60,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
              
                children: [
                  Text(hutDetail.name, style: ProjectText.title,),

                  Row(
                    children: [
                      Expanded(child: Text(hutDetail.place, style: ProjectText.subtitle,)),
                      Text(hutDetail.region, style: ProjectText.subtitle),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}