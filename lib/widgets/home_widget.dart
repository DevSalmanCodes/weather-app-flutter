import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:weather_app_flutter/extensions/sized_box_extension.dart';
import 'package:weather_app_flutter/widgets/widgets.dart';

import '../constants/constants.dart';
import '../models/weather.dart';
import '../view_models/home_view_model.dart';

class HomeWidget extends StatelessWidget {
  final WeatherData weatherData;
  final String currentSky;
  final double temp, maxTemp, minTmp;
  final ListElement currentWeather;
  final VoidCallback onLocationTap;
  final Widget textFieldWiget;

  const HomeWidget({
    super.key,
    required this.weatherData,
    required this.currentSky,
    required this.temp,
    required this.maxTemp,
    required this.minTmp,
    required this.currentWeather,
    required this.onLocationTap,
    required this.textFieldWiget,
  });

  String _formatDate(DateTime dateTime) {
    return DateFormat('EEEE, MMM d').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    final isExpanded = context.select<HomeViewModel, bool>(
        (homeViewModel) => homeViewModel.isExpanded);
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.03,
          ),
          if (!isExpanded)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  weatherData.city.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 18.0,
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      tooltip: 'Get my location weather',
                      onPressed: onLocationTap,
                      icon: const Icon(
                        Icons.my_location,
                        color: Colors.white,
                        size: 30.0,
                      ),
                    ),
                    12.w,
                    IconButton(
                      onPressed: () {
                        if (!isExpanded) {
                          context.read<HomeViewModel>().setExpnaded(true);
                        }
                      },
                      icon: const Icon(
                        Icons.search,
                        color: Colors.white,
                        size: 30.0,
                      ),
                    )
                  ],
                ),
              ],
            ),
          if (isExpanded)
            Row(
              children: [
                textFieldWiget,
                IconButton(
                  onPressed: () {
                    context.read<HomeViewModel>().setExpnaded(false);
                  },
                  icon: const Icon(Icons.close),
                  color: Colors.white,
                  iconSize: 30.0,
                )
              ],
            ),
          const SizedBox(height: 15.0),
          SizedBox(
            height: 150,
            child: Lottie.asset(
              currentSky == 'Clear'
                  ? 'assets/clear.json'
                  : currentSky == 'Clouds'
                      ? 'assets/clouds.json'
                      : currentSky == 'Rain'
                          ? 'assets/rain.json'
                          : '',
            ),
          ),
          Text(
            '${temp.toStringAsFixed(0)}°',
            style: appTextStyle().copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          ),
          10.h,
          Text(
            currentSky == 'Clear'
                ? 'Clear'
                : currentSky == 'Clouds'
                    ? 'Clouds'
                    : currentSky == 'Rain'
                        ? 'Rain'
                        : '',
            style: appTextStyle().copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
          10.h,
          Text('Precipitations', style: appTextStyle()),
          Text(
            'Max: ${maxTemp.toStringAsFixed(2)}° Min: ${minTmp.toStringAsFixed(2)}°',
            style: appTextStyle(),
          ),
          15.h,
          Card(
            color: Colors.transparent,
            elevation: 8.0,
            child: Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                  color: const Color(0Xff0d3989),
                  borderRadius: BorderRadius.circular(15.0),
                  boxShadow: [
                    BoxShadow(
                        color: const Color.fromARGB(255, 216, 218, 223)
                            .withOpacity(0.6),
                        offset: const Offset(1, -1))
                  ]),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset('assets/rain_drops.svg'),
                      5.w,
                      Text(
                        '${currentWeather.main.humidity}%',
                        style: appTextStyle(),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      SvgPicture.asset('assets/therma.svg'),
                      5.w,
                      Text(
                        '16%', // Assuming this is constant for now
                        style: appTextStyle(),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      SvgPicture.asset('assets/wind.svg'),
                      5.w,
                      Text(
                        '${currentWeather.wind.speed} km/h',
                        style: appTextStyle(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          10.h,
          TodayForecast(
            date: _formatDate(currentWeather.dtTxt),
            listElement: weatherData.list,
          ),
          15.h,
          NextForecast(
            listElement: weatherData.list,
          ),
          70.h
        ],
      ),
    );
  }
}
