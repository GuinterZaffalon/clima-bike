import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../service/fetch-cities.dart';

class ResultParam {
  String? firstCity = "";
  String? seccondCity = "";

  ResultParam({this.firstCity, this.seccondCity});
}

class ResultFetch extends StatefulWidget {
  final ResultParam resultParam;
  const ResultFetch({Key? key, required this.resultParam}) : super(key: key);

  @override
  State<ResultFetch> createState() => _ResultFetchState();
}

class _ResultFetchState extends State<ResultFetch> {
  List<String> cities = [];
  String distance = "";

  @override
  void initState() {
    super.initState();
    _getDistance(
        widget.resultParam.firstCity!, widget.resultParam.seccondCity!);
  }

  Future<void> _getDistance(String firstCity, String seccondCity) async {
    try {
      final distanceFetched =
          await FetchCities.fetchCities(firstCity, seccondCity);
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
      body: Column(children: [
        Padding(
            padding: const EdgeInsets.fromLTRB(10, 25, 10, 0),
            child: Text(
              "Distância: $distance",
              style: GoogleFonts.roboto(
                color: Colors.black,
                fontSize: 20,
              ),
            )),
        Padding(
            padding: const EdgeInsets.fromLTRB(10, 25, 10, 0),
            child: Text(
              "Cidades: ${cities.join(", ")}",
              style: GoogleFonts.roboto(
                color: Colors.black,
                fontSize: 20,
              ),
            ))
      ]),
    );
  }
}
