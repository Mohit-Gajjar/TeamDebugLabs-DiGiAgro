import 'package:flutter/material.dart';

class Weather extends StatefulWidget {
  final String summary;
  final String icon;
  final double temprature;
  final double apperentTemperature;
  final String dewPoint;
  final String humidity;
  final String pressure;
  final String uvindex;
  final String ozone;

  const Weather(
      {Key? key,
      required this.summary,
      required this.icon,
      required this.temprature,
      required this.apperentTemperature,
      required this.dewPoint,
      required this.humidity,
      required this.pressure,
      required this.uvindex,
      required this.ozone})
      : super(key: key);

  @override
  _WeatherState createState() => _WeatherState();
}

class _WeatherState extends State<Weather> {
  double temp = 0.0;
  double apperentTemp = 0.0;

  @override
  Widget build(BuildContext context) {
    temp = (widget.temprature - 32) * 5 / 9;
    apperentTemp = (widget.apperentTemperature - 32) * 5 / 9;
    return SingleChildScrollView(
      child: Column(
        children: [
          Image(
            image: NetworkImage(
                "https://assetambee.s3-us-west-2.amazonaws.com/weatherIcons/PNG/" +
                    widget.icon +
                    ".png"),
            width: MediaQuery.of(context).size.width / 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Summary: ",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  Text(
                    "temprature: ",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  Text(
                    "Apper Temp: ",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  Text(
                    "DewPoint: ",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  Text(
                    "Humidity: ",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  Text(
                    "Pressure: ",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  Text(
                    "UV Index: ",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    widget.summary,
                    style: const TextStyle(fontSize: 18),
                  ),
                  Text(
                    temp.toStringAsFixed(2) + " ℃",
                    style: const TextStyle(fontSize: 18),
                  ),
                  Text(
                    apperentTemp.toStringAsFixed(2) + " ℃",
                    style: const TextStyle(fontSize: 18),
                  ),
                  Text(
                    widget.dewPoint + " ° F",
                    style: const TextStyle(fontSize: 18),
                  ),
                  Text(
                    widget.humidity + " %",
                    style: const TextStyle(fontSize: 18),
                  ),
                  Text(
                    widget.pressure + " hPa",
                    style: const TextStyle(fontSize: 18),
                  ),
                  Text(
                    widget.uvindex,
                    style: const TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
