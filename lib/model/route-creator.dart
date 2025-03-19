import 'package:http/http.dart' as http;
import 'dart:convert';

class RouteCreator {
  static Future<Map<String, dynamic>> createRoute(List<List<double>> coordinates) async {
    const String baseUrl = "api.openrouteservice.org";
    const String path = "/v2/directions/driving-car";
    const String apiKey = "5b3ce3597851110001cf624861c8eb00eb2f4ffc90c8b04710119ae1";

    final Uri route = Uri.https(baseUrl, path, {
      "api_key": apiKey,
      "start": "${coordinates[0][0]},${coordinates[0][1]}",
      "end": "${coordinates[1][0]},${coordinates[1][1]}",
    });

    print(route);

    try{
      final response = await http.get(route);
      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);

        final features = result["features"] as List;

        final geometry = features[0]["geometry"] as Map<String, dynamic>;
        final coordinates = geometry["coordinates"] as List;

        final properties = features[0]["properties"] as Map<String, dynamic>;
        final segments = properties["segments"] as List;
        final distance = segments[0]["distance"];

        return {
          "distance": distance,
          "coordinates": coordinates
        };
      } else {
        print ("erro na primeira busca: ${response.statusCode}");
        return {"error": response.statusCode};
      }
    } catch (e) {
      return {"error": e};
    }
  }
}