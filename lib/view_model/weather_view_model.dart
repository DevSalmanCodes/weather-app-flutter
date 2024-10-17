// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';

import 'package:weather_app_flutter/services/services.dart';
import 'package:weather_app_flutter/repositories/weather_repository.dart';

import '../constants/constants.dart';
import '../models/weather.dart';
import '../utils/snanckbar.dart';

class WeatherViewModel extends ChangeNotifier {
  final WeatherRepository _weatherRepository = WeatherRepository();
  final LocationService _locationService = LocationService();
  final SharedPreferencesService _sharedPreferencesService =
      SharedPreferencesService();
  String? city;
  WeatherData? _weatherData;
  WeatherData? get weatherData => _weatherData;
  bool _isGettingLocation = false;
  bool get isGettingLocation => _isGettingLocation;

  void _setLoading(bool value) {
    _isGettingLocation = value;
    notifyListeners();
  }

  getDefaultLocationWeather(BuildContext context) async {
    try {
      final res = await _weatherRepository.getWeather(defaultCity);
      _weatherData = WeatherData.fromJson(res);
      notifyListeners();
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<void> getInitWeather(BuildContext context) async {
    final userCity = await _getSharedPreferencesData(context, 'city');
    city = userCity;
    if (userCity == null) {
      getDefaultLocationWeather(context);
    } else {
      getUserLocationWeather(context, userCity);
    }
  }

  Future<void> getUserLocationAndWeather(BuildContext context) async {
    _setLoading(true);

    try {
      final userCity = await _locationService.getCityName();

      _sharedPreferencesService.storeData('city', userCity);
      final res = await _weatherRepository.getWeather(userCity);
      _weatherData = WeatherData.fromJson(res);
      _setLoading(false);
    } catch (e) {
      _setLoading(false);

      showSnackBar(context, e.toString());
      throw e.toString();
    }
  }

  Future<void> getUserLocationWeather(BuildContext context, String city) async {
    try {
      final res = await _weatherRepository.getWeather(city);
      _weatherData = WeatherData.fromJson(res);
      notifyListeners();
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<String?> _getSharedPreferencesData(
      BuildContext context, String key) async {
    try {
      final res = await _sharedPreferencesService.getData(key);
      return res;
    } catch (error) {
      showSnackBar(context, error.toString());
      return null;
    }
  }

  Future<void> getSearchWeather(
      BuildContext context, String searchQuery) async {
    _setLoading(true);
    try {
      final res = await _weatherRepository.getWeather(searchQuery);
      _weatherData = WeatherData.fromJson(res);
      _setLoading(false);
    } catch (e) {
      _setLoading(false);
      showSnackBar(context, e.toString());
    }
  }

  Future<void> onRefresh(BuildContext context) async {
    final res = await _weatherRepository.getWeather(city ?? defaultCity);
    _weatherData = WeatherData.fromJson(res);
    notifyListeners();
  }
}
