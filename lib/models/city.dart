
class City {
  final int id, population, timezone, sunrise, sunset;
  final String name, country;
  final Coord coord;

  City({
    required this.id,
    required this.name,
    required this.coord,
    required this.country,
    required this.population,
    required this.timezone,
    required this.sunrise,
    required this.sunset,
  });

  factory City.fromJson(Map<String, dynamic> json) => City(
        id: json['id'],
        name: json['name'],
        coord: Coord.fromJson(json['coord']),
        country: json['country'],
        population: json['population'],
        timezone: json['timezone'],
        sunrise: json['sunrise'],
        sunset: json['sunset'],
      );
}

class Coord {
  final double lat, lon;

  Coord({required this.lat, required this.lon});

  factory Coord.fromJson(Map<String, dynamic> json) => Coord(
        lat: json['lat'].toDouble(),
        lon: json['lon'].toDouble(),
      );
}