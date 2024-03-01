import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:logger/logger.dart';
import 'package:topomapper/map_page/map_page.dart';
import 'package:topomapper/models/hut.dart';

var log = Logger();
List<Hut> huts = [];

void main() async {
  await dotenv.load(fileName: 'config.env');

  huts = await getHutsFromDocApi();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: Scaffold(
        extendBody: true,
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              label: 'Map',
              icon: Icon(Icons.map)
            ),
            BottomNavigationBarItem(
              label: 'Navigate',
              icon: Icon(Icons.navigation)
            ),
            BottomNavigationBarItem(
              label: 'Settings',
              icon: Icon(Icons.settings)
            ),
          ],
        ),

        body: MapPage(huts: huts)
      ),
    );
  }
}
