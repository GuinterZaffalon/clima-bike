import 'package:flutter/material.dart';
import 'package:flutterprojects/service/fetch-cities.dart';
import 'package:google_fonts/google_fonts.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> cities = [];
  String distance = "";
  final TextEditingController firstCity = TextEditingController();
  final TextEditingController seccondCity = TextEditingController();

  Future<void> _getDistance(String firstCity, String seccondCity) async {
    try {
      final distanceFetched = await FetchCities.fetchCities(firstCity, seccondCity);
      final distanceCalculated = distanceFetched["distance"];
      final citiesFetched = distanceFetched["cities"];
      if (distanceCalculated == "") {
        setState(() {
          distance = "";
        });
      } else {
        setState(() {
          distance = distanceCalculated;
          cities = citiesFetched;
        });
      }
    } catch (e) {
      setState(() {
        distance = "";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(99, 176, 205, 100),
        title: Text("Clima Bike"),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.white,
        alignment: Alignment.topCenter,
        child: Column(
          children: [
            Padding(padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
              child: TextField(
                controller: firstCity,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: const BorderSide(
                      color: Colors.black,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: const BorderSide(
                      color: Colors.blue,
                    ),
                  ),
                  suffixIcon: const Icon(Icons.search),
                  contentPadding: const EdgeInsets.all(15.0),
                  hintText: Text("Cidade de Partida").data,
                )
              )
            ),
            Padding(padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                child: TextField(
                  controller: seccondCity,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: const BorderSide(
                          color: Colors.black,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: const BorderSide(
                          color: Colors.blue,
                        ),
                      ),
                      suffixIcon: const Icon(Icons.search),
                      contentPadding: const EdgeInsets.all(15.0),
                      hintText: Text("Cidade de Chegada").data,
                    )
                )
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 25, 10, 0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    _getDistance(firstCity.text, seccondCity.text);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    padding: const EdgeInsets.all(13),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: const Text("Calcular", style: TextStyle(color: Colors.black),),
                ),
              ),
            ),
            distance != "" ? Padding(
              padding: const EdgeInsets.fromLTRB(10, 25, 10, 0),
              child: Text(
                "Distância: $distance",
                style: GoogleFonts.roboto(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
            ) : Container(),
            cities.isNotEmpty ? Padding(
              padding: const EdgeInsets.fromLTRB(10, 25, 10, 0),
              child: ListView(
                children: cities.map((city) => Text(city)).toList(),
              ),
            ) : Container(),
          ],
        )
      )
    );
  }
}