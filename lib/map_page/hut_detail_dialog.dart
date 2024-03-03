import 'package:flutter/material.dart';
import 'package:topomapper/models/hut_detail.dart';
import 'package:topomapper/style/project_text.dart';
import 'package:url_launcher/url_launcher.dart';

class HutDetailDialog extends StatelessWidget {
  const HutDetailDialog({super.key, required this.hutDetail});

  final HutDetail hutDetail;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      builder: (_, controller) => Stack(
        alignment: Alignment.topCenter,
        clipBehavior: Clip.none,
        children: [
          // Circular hut thumbnail.
          Positioned(
            top: -55,
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
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.4,
              child: ListView(
                // crossAxisAlignment: CrossAxisAlignment.start,
              
                children: [
                  Row(
                    children: [
                      Text(hutDetail.name, style: ProjectText.title),
                      const Spacer(),
                      Text(hutDetail.numberOfBunks.toString()),
                      const Icon(Icons.bed)
                    ],
                  ),
                  
                  Row(
                    children: [
                      Text(hutDetail.place, style: ProjectText.subtitle(),),
                      const Spacer(),
                      Text(hutDetail.region, style: ProjectText.subtitle()),
                    ],
                  ),
                  
                  const Divider(),
                  
                  Row(
                    children: [
                      Text(hutDetail.status, style: TextStyle(color: (hutDetail.status == 'OPEN') ? Colors.green : Colors.red)),
                      const Spacer(),
                      Text((hutDetail.bookable) ? 'Bookable' : 'Not bookable'),
                    ],
                  ),
                          
                  const SizedBox(height: 10),
                          
                  Text(hutDetail.introduction),
                  
                  const SizedBox(height: 10),
                  
                  for (var facility in hutDetail.facilities) Text('· $facility'),
                          
                  const SizedBox(height: 10),
                          
                  InkWell(
                    onTap: () {
                      launchUrl(Uri.parse(hutDetail.staticLink));
                    },
                    child: Text('DOC website', style: ProjectText.link,),
                  ),
                  
                  const SizedBox(height: 10,),
                  
                  Text('${hutDetail.lat}, ${hutDetail.lon}', style: ProjectText.subtitle()),


                  const SizedBox(height: 10),
                          
                  Text('Check with DOC staff for latest hut information before you go', style: ProjectText.subtitle(italics: true),)
                  
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}