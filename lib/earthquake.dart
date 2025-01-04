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

  // Factory constructor to create an Earthquake object from JSON data
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
