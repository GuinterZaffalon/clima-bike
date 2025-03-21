import 'package:http/http.dart' as http;
import 'dart:convert';

class CityCounter {
  static Future<List<String>> getCityCounter(List<List<double>> coordinaties) async {
    List<String> citiesFetch = [];
    List<List<double>> waypoints = getCityNames(coordinaties, 90);

    for (var coord in waypoints) {
      double lat = coord[1];
      double lon = coord[0];

      final url = Uri.parse(
          'https://nominatim.openstreetmap.org/reverse?format=json&lat=$lat&lon=$lon'
      );
      print(url);

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        print(result);
        if (result["address"] != null) {
          String? city = result["address"]["city"] ?? result["address"]["town"];
          if (city != null) {
            citiesFetch.add(city);
          }
        }
      }

    }

    print(citiesFetch);
    return citiesFetch;
  }

  static List<List<double>> getCityNames(List<List<double>> coordinaties, int ratingSearch) {
    List<List<double>> waypoints = [];

    for (int i = 0; i < coordinaties.length; i += ratingSearch) {
      waypoints.add(coordinaties[i]);
    }
    
    if  (waypoints.last != coordinaties.last) {
      waypoints.add(coordinaties.last);
    }
    return waypoints;
  }

}
