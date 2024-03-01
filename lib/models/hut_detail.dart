// To parse this JSON data, do
//
//     final hutDetail = hutDetailFromJson(jsonString);

import 'dart:convert';
import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:topomapper/main.dart';

HutDetail hutDetailFromJson(String str) => HutDetail.fromJson(json.decode(str));

String hutDetailToJson(HutDetail data) => json.encode(data.toJson());

class HutDetail {
    int assetId;
    String name;
    String locationString;
    int numberOfBunks;
    List<String> facilities;
    String hutCategory;
    dynamic proximityToRoadEnd;
    bool bookable;
    String introduction;
    String introductionThumbnail;
    String staticLink;
    String region;
    String place;
    String status;
    double lon;
    double lat;

    HutDetail({
        required this.assetId,
        required this.name,
        required this.locationString,
        required this.numberOfBunks,
        required this.facilities,
        required this.hutCategory,
        required this.proximityToRoadEnd,
        required this.bookable,
        required this.introduction,
        required this.introductionThumbnail,
        required this.staticLink,
        required this.region,
        required this.place,
        required this.status,
        required this.lon,
        required this.lat,
    });

    factory HutDetail.fromJson(Map<String, dynamic> json) => HutDetail(
        assetId: json["assetId"],
        name: json["name"],
        locationString: json["locationString"],
        numberOfBunks: json["numberOfBunks"],
        facilities: List<String>.from(json["facilities"].map((x) => x)),
        hutCategory: json["hutCategory"],
        proximityToRoadEnd: json["proximityToRoadEnd"],
        bookable: json["bookable"],
        introduction: json["introduction"],
        introductionThumbnail: json["introductionThumbnail"],
        staticLink: json["staticLink"],
        region: json["region"],
        place: json["place"],
        status: json["status"],
        lon: json["lon"]?.toDouble(),
        lat: json["lat"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "assetId": assetId,
        "name": name,
        "locationString": locationString,
        "numberOfBunks": numberOfBunks,
        "facilities": List<dynamic>.from(facilities.map((x) => x)),
        "hutCategory": hutCategory,
        "proximityToRoadEnd": proximityToRoadEnd,
        "bookable": bookable,
        "introduction": introduction,
        "introductionThumbnail": introductionThumbnail,
        "staticLink": staticLink,
        "region": region,
        "place": place,
        "status": status,
        "lon": lon,
        "lat": lat,
    };
}

Future<HutDetail> getHutDetailFromDocApi(int assetId) async {
  HutDetail hutDetail;

  final response = await http.get(
    Uri.parse('https://api.doc.govt.nz/v2/huts/$assetId/detail?coordinates=nzgd2000'),
    headers: {
      'x-api-key': dotenv.env['DOC_API_KEY']!,
      HttpHeaders.acceptHeader: 'application/json'
    }
  );

  if (response.statusCode == 200) {
    hutDetail = hutDetailFromJson(response.body);
    
    log.f('${response.statusCode}: got detail of ${hutDetail.name} from DOC API.');
    
    return hutDetail;

  } else {
    log.e('${response.statusCode}: unable to get hut detail from DOC API!');

    throw UnimplementedError();
  }
}
