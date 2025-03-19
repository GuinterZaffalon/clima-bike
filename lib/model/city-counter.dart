import 'package:http/http.dart' as http;
import 'dart:convert';

class CityCounter {
 static Future<List<String>> getCityCounter(List<List<double>> coordinaties) async {
   List<String> citiesFetch = [];
   List<List<List<double>>> waypoints = getCityNames(coordinaties, 90);

   for(var waypoint in waypoints) {
     for(var coord in waypoint) {
       double lat = coord[0];
       double lon = coord[1];

       final url = Uri.parse(
         'https://nominatim.openstreetmap.org/reverse?format=json&lat=$lat&lon=$lon'
       );

       final response = await http.get(url);

       if (response.statusCode == 200) {
         final result = jsonDecode(response.body);
         if (result["address"] != null && result["address"]["city"] != null) {
           citiesFetch.add(result["address"]["city"]);
         }
       }
     }
   }
   print(citiesFetch);
   return citiesFetch;
 }

 static List<List<List<double>>> getCityNames(List<List<double>> coordinaties, int ratingSearch) {
   List<List<List<double>>> waypoints = [];

   for (int i = 0; i < coordinaties.length; i += ratingSearch) {
     int fim = (i + ratingSearch < coordinaties.length) ? i + ratingSearch : coordinaties.length;
     waypoints.add(coordinaties.sublist(i, fim));
   }

   return waypoints;
 }
}