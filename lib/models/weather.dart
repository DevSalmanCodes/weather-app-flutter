import 'city.dart';

class WeatherData {
  final String cod;
  final int message, cnt;
  final List<ListElement> list;
  final City city;

  WeatherData({
    required this.cod,
    required this.message,
    required this.cnt,
    required this.list,
    required this.city,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) => WeatherData(
        cod: json['cod'],
        message: json['message'],
        cnt: json['cnt'],
        list: List<ListElement>.from(
            json['list'].map((x) => ListElement.fromJson(x))),
        city: City.fromJson(json['city']),
      );
}


class ListElement {
  final int dt, visibility;
  final MainClass main;
  final List<Weather> weather;
  final Clouds clouds;
  final Wind wind;
  final double pop;
  final Sys sys;
  final DateTime dtTxt;
  final Rain? rain;

  ListElement({
    required this.dt,
    required this.main,
    required this.weather,
    required this.clouds,
    required this.wind,
    required this.visibility,
    required this.pop,
    required this.sys,
    required this.dtTxt,
    this.rain,
  });

  factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
        dt: json['dt'],
        main: MainClass.fromJson(json['main']),
        weather:
            List<Weather>.from(json['weather'].map((x) => Weather.fromJson(x))),
        clouds: Clouds.fromJson(json['clouds']),
        wind: Wind.fromJson(json['wind']),
        visibility: json['visibility'],
        pop: json['pop'].toDouble(),
        sys: Sys.fromJson(json['sys']),
        dtTxt: DateTime.parse(json['dt_txt']),
        rain: json['rain'] != null ? Rain.fromJson(json['rain']) : null,
      );
}

class Clouds {
  final int all;

  Clouds({required this.all});

  factory Clouds.fromJson(Map<String, dynamic> json) => Clouds(
        all: json['all'],
      );
}

class MainClass {
  final double temp, feelsLike, tempMin, tempMax, tempKf;
  final int pressure, seaLevel, grndLevel, humidity;

  MainClass({
    required this.temp,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.pressure,
    required this.seaLevel,
    required this.grndLevel,
    required this.humidity,
    required this.tempKf,
  });

  factory MainClass.fromJson(Map<String, dynamic> json) => MainClass(
        temp: json['temp'].toDouble(),
        feelsLike: json['feels_like'].toDouble(),
        tempMin: json['temp_min'].toDouble(),
        tempMax: json['temp_max'].toDouble(),
        pressure: json['pressure'],
        seaLevel: json['sea_level'],
        grndLevel: json['grnd_level'],
        humidity: json['humidity'],
        tempKf: json['temp_kf'].toDouble(),
      );
}

class Rain {
  final double the3H;

  Rain({required this.the3H});

  factory Rain.fromJson(Map<String, dynamic> json) => Rain(
        the3H: json['3h'].toDouble(),
      );
}

class Sys {
  final String pod;

  Sys({required this.pod});

  factory Sys.fromJson(Map<String, dynamic> json) => Sys(
        pod: json['pod'],
      );
}

class Weather {
  final int id;
  final String main, description, icon;

  Weather({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
  });

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
        id: json['id'],
        main: json['main'],
        description: json['description'],
        icon: json['icon'],
      );
}

class Wind {
  final double speed, gust;
  final int deg;

  Wind({required this.speed, required this.deg, required this.gust});

  factory Wind.fromJson(Map<String, dynamic> json) => Wind(
        speed: json['speed'].toDouble(),
        deg: json['deg'],
        gust: json['gust'].toDouble(),
      );
}
