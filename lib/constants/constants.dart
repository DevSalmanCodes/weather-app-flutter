import 'package:flutter/material.dart';

import '../models/weather.dart';

const String openWeatherApiKey = '43ea3e59c1a2ab047e0412ec2f8eefc6';
const defaultCity = 'Peshawar';

TextStyle appTextStyle() {
  return const TextStyle(color: Colors.white, fontSize: 16.0);
}

(double, double, double) kelvinToCelsius(MainClass main) {
  const double kelvinDifference = 273.15;
  return (
    (main.temp - kelvinDifference).floorToDouble(),
    main.tempMax - kelvinDifference,
    main.tempMin - kelvinDifference
  );
}
