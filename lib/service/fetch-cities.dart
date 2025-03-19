import 'package:flutterprojects/model/search-coordinates.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../model/route-creator.dart';

class FetchCities {
  static Future<Map<String, dynamic>> fetchCities(String firstCity, String seccondCity) async {
    try {
      final List<List<double>> coordinaties = await SearchCoordinates.getCoordinates(firstCity, seccondCity);
      final Map<String, dynamic> route = await RouteCreator.createRoute(coordinaties);
      String formattedDistance = "${(route["distance"] / 1000).toStringAsFixed(1)} Km";

      return {"distance": formattedDistance, "coordinates": route["coordinates"]};
    } catch (e) {
      return {"e": e};
    }
  }
}