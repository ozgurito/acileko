// earthquake_list_screen.dart

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// Earthquake Model class
class Earthquake {
  final String earthquakeId;
  final String provider;
  final String title;
  final String date;
  final double mag;
  final double depth;
  final List<double> coordinates; // [longitude, latitude]
  final String closestCity;
  final double distanceToCity;
  final List<String> closestCities;
  final List<String> airports;

  Earthquake({
    required this.earthquakeId,
    required this.provider,
    required this.title,
    required this.date,
    required this.mag,
    required this.depth,
    required this.coordinates,
    required this.closestCity,
    required this.distanceToCity,
    required this.closestCities,
    required this.airports,
  });

  factory Earthquake.fromJson(Map<String, dynamic> json) {
    var geojson = json['geojson']['coordinates'];
    return Earthquake(
      earthquakeId: json['earthquake_id'],
      provider: json['provider'],
      title: json['title'],
      date: json['date'],
      mag: json['mag'].toDouble(),
      depth: json['depth'].toDouble(),
      coordinates: [geojson[0], geojson[1]], // longitude, latitude
      closestCity: json['location_properties']['closestCity']['name'],
      distanceToCity: json['location_properties']['closestCity']['distance'],
      closestCities: List<String>.from(json['location_properties']['closestCities'].map((city) => city['name'])),
      airports: List<String>.from(json['location_properties']['airports'].map((airport) => airport['name'])),
    );
  }
}

// Function to fetch earthquake data from API
Future<List<Earthquake>> fetchEarthquakeData() async {
  final response = await http.get(Uri.parse('https://api.orhanaydogdu.com.tr/deprem/kandilli/live'));

  if (response.statusCode == 200) {
    List<dynamic> data = json.decode(response.body);
    return data.map((json) => Earthquake.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load earthquake data');
  }
}

class EarthquakeListScreen extends StatefulWidget {
  @override
  _EarthquakeListScreenState createState() => _EarthquakeListScreenState();
}

class _EarthquakeListScreenState extends State<EarthquakeListScreen> {
  late Future<List<Earthquake>> futureEarthquakes;

  @override
  void initState() {
    super.initState();
    futureEarthquakes = fetchEarthquakeData(); // Fetch earthquake data when screen is initialized
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Son Depremler"),
      ),
      body: FutureBuilder<List<Earthquake>>(
        future: futureEarthquakes,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No data available.'));
          } else {
            List<Earthquake> earthquakes = snapshot.data!;
            return ListView.builder(
              itemCount: earthquakes.length,
              itemBuilder: (context, index) {
                Earthquake earthquake = earthquakes[index];
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                  elevation: 5,
                  child: ListTile(
                    title: Text(earthquake.title),
                    subtitle: Text(
                      '${earthquake.date}\nMagnitude: ${earthquake.mag} Depth: ${earthquake.depth} km\nClosest City: ${earthquake.closestCity} (Distance: ${earthquake.distanceToCity.toStringAsFixed(2)} km)',
                      style: TextStyle(fontSize: 14),
                    ),
                    isThreeLine: true,
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
// TODO Implement this library.