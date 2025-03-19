import 'package:flutterprojects/model/search-coordinates.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../model/route-creator.dart';

class MountRoute {
  static Future<String> mountRoute(String firstCity, String seccondCity) async {
    try {
      final List<List<double>> coordinaties = await SearchCoordinates.getCoordinates(firstCity, seccondCity);
      // if (coordinaties.length < 2) {
      //   return []; // Garante que há duas cidades antes de processar
      // }



      final double route = await RouteCreator.createRoute(coordinaties);
      String formattedDistance = "${(route / 1000).toStringAsFixed(1)} Km";
      return formattedDistance;
    } catch (e) {
      return "";
    }
  }
}