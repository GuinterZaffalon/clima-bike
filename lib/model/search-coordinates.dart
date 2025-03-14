import 'package:http/http.dart' as http;
import 'dart:convert';

class SearchCoordinates {
  static Future<List<String>> getCoordinates(String firstCity, String seccondCity) async {
    const String baseUrl = "api.openrouteservice.org";
    const String path = "/geocode/search";
    const String apiKey = "5b3ce3597851110001cf624861c8eb00eb2f4ffc90c8b04710119ae1";

    final Uri searchFirstCity = Uri.https(baseUrl, path, {
      "api_key": apiKey,
      "layers": "locality",
      "text": firstCity,
    });

    final Uri searchSeccondCity = Uri.https(baseUrl, path, {
      "api_key": apiKey,
      "layers": "locality",
      "text": seccondCity,
    });

    try{
      final firstSearch = await http.get(searchFirstCity);
      final seccondSearch = await http.get(searchSeccondCity);

      String resultFetchFirstCity = firstSearch.["features"]["geometry"]["coordinates"];
    } catch (e) {
      return [];
    }
  }
}
