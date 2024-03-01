
// To parse this JSON data, do
//
//     final hut = hutFromJson(jsonString);

import 'dart:convert';
import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:topomapper/main.dart';
import 'package:http/http.dart' as http;

List<Hut> hutsFromJson(String str) => List<Hut>.from(json.decode(str).map((x) => Hut.fromJson(x)));

String hutsToJson(List<Hut> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Hut {
    int assetId;
    String name;
    String status;
    String? region;
    double lat;
    double lon;

    Hut({
        required this.assetId,
        required this.name,
        required this.status,
        required this.region,
        required this.lat,
        required this.lon,
    });

    factory Hut.fromJson(Map<String, dynamic> json) => Hut(
        assetId: json["assetId"],
        name: json["name"],
        status: json["status"],
        region: json["region"],
        lat: json["lat"]?.toDouble(),
        lon: json["lon"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "assetId": assetId,
        "name": name,
        "status": status,
        "region": region,
        "lat": lat,
        "lon": lon,
    };
}

/// Returns a list of huts from the New Zealand Department of Conservation's
/// huts API.
Future<List<Hut>> getHutsFromDocApi() async {
  List<Hut> huts = [];

  log.f('Attempting to get huts list from DOC API...');
  
  final response = await http.get(
    Uri.parse('https://api.doc.govt.nz/v2/huts?coordinates=nzgd2000'),
    headers: {
      'x-api-key': dotenv.env['DOC_API_KEY']!,
      HttpHeaders.acceptHeader: 'application/json'
    }
  );

  
  if (response.statusCode == 200) {
    huts = hutsFromJson(response.body);

    log.f('${response.statusCode}: successfully gotten list of ${huts.length} huts from DOC API.');

  } else {
    log.e('${response.statusCode}: unable to get huts list from DOC API!');
  }

  return huts;
}