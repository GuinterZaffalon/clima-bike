import 'package:flutterprojects/model/search-coordinates.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../model/route-creator.dart';

class MountRoute {
  static Future<List<String>> mountRoute(String firstCity, String seccondCity) async {
    try {
      final coordinaties = await SearchCoordinates.getCoordinates(firstCity, seccondCity);
      final route = await RouteCreator.createRoute(coordinaties);
      return route;
    } catch (e) {
      return [];
    }
  }
}