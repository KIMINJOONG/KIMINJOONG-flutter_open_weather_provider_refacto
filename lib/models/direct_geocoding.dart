class DirectGeocoding {
  final String name;
  final double lat;
  final double lon;
  final String country;

  DirectGeocoding(
      {required this.name,
      required this.lat,
      required this.lon,
      required this.country});

  factory DirectGeocoding.fromJson(List<dynamic> json) {
    final Map<String, dynamic> data = json[0];

    return DirectGeocoding(
      name: data['name'],
      lat: data['lat'],
      lon: data['lon'],
      country: data['country'],
    );
  }

  List<Object> get props => [name, lat, lon, country];

  @override
  String toString() {
    return 'DirectGeocoding{name: $name, lat: $lat, lon: $lon, country: $country}';
  }
}
