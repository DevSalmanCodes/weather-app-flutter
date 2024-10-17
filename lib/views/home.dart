import 'dart:ui';

import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'package:provider/provider.dart';
import 'package:weather_app_flutter/view_models/weather_view_model.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:weather_app_flutter/widgets/home_widget.dart';

import '../constants/constants.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getWeather();

    initializeDateFormatting('en_US', null);
  }

  void _getWeather() {
    Provider.of<WeatherViewModel>(context, listen: false)
        .getInitWeather(context);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Widget _textFieldWiget() {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
            color: Colors.transparent.withOpacity(0.2),
            borderRadius: BorderRadius.circular(10.0)),
        child: TextField(
          controller: _searchController,
          onSubmitted: (provider) {
            context
                .read<WeatherViewModel>()
                .getSearchWeather(context, _searchController.text.trim());
            _searchController.clear();
          },
          style: appTextStyle(),
          decoration: InputDecoration(
              hintText: 'Search',
              hintStyle: appTextStyle(),
              border: const OutlineInputBorder(
                borderSide: BorderSide.none,
              )),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<WeatherViewModel>(
      builder: (context, value, child) => Scaffold(
        body: Container(
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                const Color(0Xff092a5f),
                value.weatherData == null
                    ? const Color.fromARGB(255, 17, 57, 133)
                    : const Color(0Xff124cb4)
              ],
              begin: Alignment.topLeft,
              end: Alignment.center,
            ),
          ),
          child: SafeArea(
            child: EasyRefresh(
              triggerAxis: Axis.vertical,
              onRefresh: () {
                value.onRefresh(context);
              },
              header: _buildEasyRefreshClassicHeader(),
              child: Stack(children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: value.weatherData == null
                      ? Center(
                          child: Lottie.asset('assets/loading.json',
                              height: 250.0),
                        )
                      : HomeWidget(
                          textFieldWiget: _textFieldWiget(),
                          weatherData: value.weatherData!,
                          currentSky:
                              value.weatherData!.list[0].weather[0].main,
                          temp: kelvinToCelsius(value.weatherData!.list[0].main)
                              .$1,
                          maxTemp:
                              kelvinToCelsius(value.weatherData!.list[0].main)
                                  .$2,
                          minTmp:
                              kelvinToCelsius(value.weatherData!.list[0].main)
                                  .$3,
                          currentWeather: value.weatherData!.list[0],
                          onLocationTap: () {
                            value.getUserLocationAndWeather(context);
                          },
                        ),
                ),
                if (value.isGettingLocation) ...[
                  BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
                    child: Container(
                      decoration:
                          BoxDecoration(color: Colors.black.withOpacity(0.2)),
                    ),
                  ),
                  Center(
                      child: Lottie.asset('assets/loading.json', height: 250)),
                ]
              ]),
            ),
          ),
        ),
      ),
    );
  }

  ClassicHeader _buildEasyRefreshClassicHeader() {
    return ClassicHeader(
        iconTheme: const IconThemeData(color: Colors.white),
        dragText: 'Pull To Refresh',
        readyText: 'Refreshing',
        armedText: 'Release To Refresh',
        messageStyle: appTextStyle(),
        textStyle: appTextStyle(),
        succeededIcon: const Icon(
          Icons.done,
        ));
  }
}
