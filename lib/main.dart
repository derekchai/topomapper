import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
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
    return MaterialApp(
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: Scaffold(
        body: MapPage(huts: huts)
      ),
    );
  }
}
