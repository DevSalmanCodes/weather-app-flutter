import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app_flutter/extensions/sized_box_extension.dart';

import '../constants/constants.dart';
import '../models/weather.dart';

class TodayForecast extends StatelessWidget {
  final String date;
  final List<ListElement> listElement;

  const TodayForecast({
    super.key,
    required this.date,
    required this.listElement,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
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
                  'Today',
                  style: appTextStyle()
                      .copyWith(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                Text(
                  date,
                  style: appTextStyle(),
                ),
              ],
            ),
            8.h,
            SizedBox(
              height: 120,
              child: ListView.builder(
                itemExtent: width / 6,
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                itemBuilder: (context, index) {
                  final String skyCondition =
                      listElement[index + 1].weather[0].main;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${kelvinToCelsius(listElement[index].main).$1.toStringAsFixed(0)}°',
                        style: appTextStyle(),
                      ),
                      10.h,
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
                        size: 40,
                      ),
                      10.h,
                      Text(
                        DateFormat.j().format(listElement[index + 1].dtTxt),
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
