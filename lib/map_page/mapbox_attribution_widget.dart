import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:url_launcher/url_launcher.dart';

class MapboxAttributionWidget extends StatelessWidget {
  const MapboxAttributionWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RichAttributionWidget(
      alignment: AttributionAlignment.bottomLeft,
      showFlutterMapAttribution: false,
      attributions: [
        const LogoSourceAttribution(Image(image: AssetImage('assets/mapbox_logo_black.png'))),
        TextSourceAttribution(
          'Mapbox',
          onTap: () { launchUrl(Uri.parse('https://www.mapbox.com/about/maps')); },
        ),
        TextSourceAttribution(
          'OpenStreetMap',
          onTap: () { launchUrl(Uri.parse('http://www.openstreetmap.org/about')); },
        ),
        TextSourceAttribution(
          'Improve this map',
          prependCopyright: false,
          onTap: () { launchUrl(Uri.parse('https://apps.mapbox.com/feedback/#/-74.5/40/10')); },
        ),
        const TextSourceAttribution(
          'Made with flutter_map',
          prependCopyright: false,
        ),
      ],
    );
  }
}
