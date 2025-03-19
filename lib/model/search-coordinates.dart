import 'package:http/http.dart' as http;
import 'dart:convert';

class SearchCoordinates {
  static Future<List<List<double>>> getCoordinates(String firstCity, String seccondCity) async {
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

    try {
      final firstSearch = await http.get(searchFirstCity);
      final seccondSearch = await http.get(searchSeccondCity);

      if (firstSearch.statusCode == 200 && seccondSearch.statusCode == 200) {
        final resultFetchFirstCity = jsonDecode(firstSearch.body);
        final resultFetchSeccondCity = jsonDecode(seccondSearch.body);

        if (resultFetchFirstCity["features"].isEmpty || resultFetchSeccondCity["features"].isEmpty) {
          return [];
        }

        return [
          List<double>.from(resultFetchFirstCity["features"][0]["geometry"]["coordinates"]),
          List<double>.from(resultFetchSeccondCity["features"][0]["geometry"]["coordinates"])
        ];
      } else {
        print("Erro na requisição: ${firstSearch.statusCode}, ${seccondSearch.statusCode}");
        return [];
      }
    } catch (e) {
      print("Erro ao buscar coordenadas: $e");
      return [];
    }
  }
}
