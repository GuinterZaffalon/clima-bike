import 'package:http/http.dart' as http;
import 'dart:convert';

class RouteCreator {
  static Future<List<String>> createRoute(List<String> coordinates) async {
    const String baseUrl = "api.openrouteservice.org";
    const String path = "/v2/directions/driving-car";
    const String apiKey = "5b3ce3597851110001cf624861c8eb00eb2f4ffc90c8b04710119ae1";

    final Uri route = Uri.https(baseUrl, path, {
      "api_key": apiKey,
      "start": coordinates[0],
      "end": coordinates[1],
    });

    try{
      final response = await http.get(route);
      if (response.statusCode == 200){
        final result = jsonDecode(response.body);
        final coordinates =  result["features"]["geometry"]["coordinates"];
        final distance = result["features"]["properties"]["segments"][0]["distance"];
        return [coordinates, distance];
      } else {
        print ("erro na primeira busca: ${response.statusCode}");
        return [];
      }
    } catch (e) {
      return [];
    }
  }
}