import 'package:flutterprojects/model/search-coordinates.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../model/city-counter.dart';
import '../model/route-creator.dart';

class FetchCities {
  static Future<Map<String, dynamic>> fetchCities(String firstCity, String seccondCity) async {
    try {
      final List<List<double>> coordinaties = await SearchCoordinates.getCoordinates(firstCity, seccondCity);

      final Map<String, dynamic> route = await RouteCreator.createRoute(coordinaties);
      String formattedDistance = "${(route["distance"] / 1000).toStringAsFixed(1)} Km";

      print(route["coordinates"]);
      // final List<String> citiesFetch = awacit CityCounter.getCityCounter(route["coordinates"]);
      final List<List<double>> coordinates = (route["coordinates"] as List)
          .map((coord) => (coord as List).map((e) => (e as num).toDouble()).toList())
          .toList();

      final List<String> citiesFetch = await CityCounter.getCityCounter(coordinates);

      print (citiesFetch);
      return {"distance": formattedDistance, "cities": citiesFetch};
    } catch (e) {
      return {"e": e};
    }
  }
}