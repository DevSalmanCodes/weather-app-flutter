import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app_flutter/extensions/sized_box_extension.dart';

import '../constants/constants.dart';
import '../models/weather.dart';

class NextForecast extends StatelessWidget {
  final List<ListElement> listElement;

  const NextForecast({super.key, required this.listElement});

  List<String> _getDaysFromForecast(List<ListElement> hourlyData) {
    DateFormat formatter = DateFormat('EEEE');
    List<String> days = [];
    for (var forecast in hourlyData) {
      String day = formatter.format(forecast.dtTxt);
      if (!days.contains(day)) {
        days.add(day);
      }
      if (days.length == 6) break;
    }
    return days;
  }

  List<ListElement> _getNextFiveDaysForecast(List<ListElement> hourlyData) {
    Map<String, List<ListElement>> dailyForecasts = {};

    for (var forecast in hourlyData) {
      String day = DateFormat('yyyy-MM-dd').format(forecast.dtTxt);
      if (!dailyForecasts.containsKey(day)) {
        dailyForecasts[day] = [];
      }
      dailyForecasts[day]!.add(forecast);
    }

    List<ListElement> nextFiveDaysForecast = [];
    for (var day in dailyForecasts.keys) {
      nextFiveDaysForecast.add(dailyForecasts[day]![0]);
      if (nextFiveDaysForecast.length == 6) break;
    }

    return nextFiveDaysForecast;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8.0,
      color: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
            color: const Color(0Xff0d3989),
            borderRadius: BorderRadius.circular(12.0),
            boxShadow: [
              BoxShadow(
                  color:
                      const Color.fromARGB(255, 216, 218, 223).withOpacity(0.6),
                  offset: const Offset(1, -1))
            ]),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Next Forecast',
                  style: appTextStyle()
                      .copyWith(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const Icon(
                  Icons.calendar_month,
                  color: Colors.white,
                ),
              ],
            ),
            8.h,
            SizedBox(
              height: 220,
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemExtent: 45,
                itemCount: 5,
                itemBuilder: (context, index) {
                  final fiveDaysForecastData =
                      _getNextFiveDaysForecast(listElement);
                  final String skyCondition =
                      listElement[index].weather[0].main;
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 100,
                        child: Text(
                          _getDaysFromForecast(listElement)[index + 1],
                          style: appTextStyle(),
                        ),
                      ),
                      Icon(
                        skyCondition == 'Clear'
                            ? Icons.sunny
                            : skyCondition == 'Clouds'
                                ? Icons.cloud
                                : skyCondition == 'Rain'
                                    ? Icons.cloudy_snowing
                                    : Icons.sunny,
                        color: skyCondition == 'Clear'
                            ? Colors.yellow.shade800
                            : Colors.white,
                        size: 30,
                      ),
                      Text(
                        '${kelvinToCelsius(fiveDaysForecastData[index + 1].main).$1.toStringAsFixed(0)}°',
                        style: appTextStyle(),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
