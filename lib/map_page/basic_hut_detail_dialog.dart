import 'package:flutter/material.dart';
import 'package:topomapper/models/hut.dart';
import 'package:topomapper/style/project_text.dart';

class BasicHutDetailDialog extends StatelessWidget {
  const BasicHutDetailDialog({super.key, required this.hut});

  final Hut hut;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      builder: (_, controller) => Stack(
        alignment: Alignment.topCenter,
        clipBehavior: Clip.none,
        children: [
      
          // Detail text.
          SizedBox(
            // width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.4,
            child: ListView(
              // crossAxisAlignment: CrossAxisAlignment.start,
            
              children: [
                
                Text(hut.name, style: ProjectText.title,),
                
                const Divider(),
                
                const SizedBox(height: 10),
                        
                Text('${hut.lat}, ${hut.lon}', style: ProjectText.subtitle()),
          
                const SizedBox(height: 10),
                        
                Text('Check with DOC staff for latest hut information before you go', style: ProjectText.subtitle(italics: true),)
                
              ],
            ),
          ),
        ],
      ),
    );
  }
}