// ignore_for_file: constant_identifier_names

import 'package:digiagro/Components/crop_informaiton.dart';
import 'package:digiagro/Components/select_crop.dart';
import 'package:digiagro/Sercives/local_database.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:weather/weather.dart';

enum AppState { NOT_DOWNLOADED, DOWNLOADING, FINISHED_DOWNLOADING }

class Home extends StatefulWidget {
  const Home({
    Key? key,
  }) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String city = ' ', country = ' ', state = ' ';

  LocationData? _locationData;
  Location location = Location();
  double? lat, lon;
  @override
  void initState() {
    super.initState();
    _getPermissons();
    getCropName();
  }

  String cropName = ' ';
  void getCropName() async {
    await LocalDatabase.getSavedCropSharedPrefs().then((value) {
      setState(() {
        cropName = value!;
      });
    });
  }

  _getPermissons() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    _locationData = await location.getLocation();
    setState(() {
      lat = _locationData!.latitude;
      lon = _locationData!.longitude;
    });
    queryForecast();
  }

  WeatherFactory ws = WeatherFactory('095487694b8c8643e6325b844b6dcdac');
  int temp1Min = 0, temp1Max = 0;
  int temp2Min = 0, temp2Max = 0;
  int temp3Min = 0, temp3Max = 0;
  int temp4Min = 0, temp4Max = 0;
  int temp5Min = 0, temp5Max = 0;
  int temp6Min = 0, temp6Max = 0;

  double rain1 = 0;
  double rain2 = 0;
  double rain3 = 0;
  double rain4 = 0;
  double rain5 = 0;
  double rain6 = 0;

  List<String> crops = [
    "Rice",
    "Wheat",
    "Maize",
    "Bajra",
    "Jowar",
    "soya bean",
    "groundnut",
    "cotton",
    "Sugarcane",
    "Jute",
    "Coffee",
  ];
  List<int> maxTemp = [
    35,
    20,
    27,
    30,
    32,
    30,
    30,
    37,
    27,
    35,
    30,
  ];
  List<int> minTemp = [
    20,
    15,
    21,
    25,
    20,
    26,
    27,
    21,
    21,
    24,
    25,
  ];

  AppState _state = AppState.NOT_DOWNLOADED;

  void queryForecast() async {
    setState(() {
      _state = AppState.DOWNLOADING;
    });

    List<Weather> forecast = await ws.fiveDayForecastByLocation(lat!, lon!);
    setState(() {
      _state = AppState.FINISHED_DOWNLOADING;
    });
    temp1Min = forecast[0].tempMin!.celsius!.toInt();
    temp2Min = forecast[5].tempMin!.celsius!.toInt();
    temp3Min = forecast[15].tempMin!.celsius!.toInt();
    temp4Min = forecast[25].tempMin!.celsius!.toInt();
    temp5Min = forecast[30].tempMin!.celsius!.toInt();
    temp6Min = forecast[39].tempMin!.celsius!.toInt();

    temp1Max = forecast[0].tempMax!.celsius!.toInt();
    temp2Max = forecast[5].tempMax!.celsius!.toInt();
    temp3Max = forecast[15].tempMax!.celsius!.toInt();
    temp4Max = forecast[25].tempMax!.celsius!.toInt();
    temp5Max = forecast[30].tempMax!.celsius!.toInt();
    temp6Max = forecast[39].tempMax!.celsius!.toInt();

    city = forecast[0].areaName.toString();
    country = forecast[0].country.toString();

    if (forecast[0].rainLast3Hours == null ||
        forecast[5].rainLast3Hours == null ||
        forecast[15].rainLast3Hours == null ||
        forecast[25].rainLast3Hours == null ||
        forecast[30].rainLast3Hours == null ||
        forecast[39].rainLast3Hours == null) {
      rain1 = 0;
      rain2 = 0;
      rain3 = 0;
      rain4 = 0;
      rain5 = 0;
      rain6 = 0;
    } else {
      rain1 = forecast[0].rainLast3Hours! / 10;
      rain2 = forecast[5].rainLast3Hours! / 10;
      rain3 = forecast[15].rainLast3Hours! / 10;
      rain4 = forecast[25].rainLast3Hours! / 10;
      rain5 = forecast[30].rainLast3Hours! / 10;
      rain6 = forecast[39].rainLast3Hours! / 10;
    }
  }

  Color temperatureCompare(String crop) {
    int idx = crops.indexOf(crop);
    if (temp1Max > maxTemp[idx] ||
        temp2Max > maxTemp[idx] ||
        temp3Max > maxTemp[idx] ||
        temp4Max > maxTemp[idx] ||
        temp5Max > maxTemp[idx] ||
        temp6Max > maxTemp[idx]) {
      return Colors.red;
    } else if (temp1Min < minTemp[idx] ||
        temp2Min < minTemp[idx] ||
        temp3Min < minTemp[idx] ||
        temp4Min < minTemp[idx] ||
        temp5Min < minTemp[idx] ||
        temp6Min < minTemp[idx]) {
      return Colors.blue.shade300;
    }
    return Colors.green;
  }

  IconData? temperatureIcon(String crop) {
    int idx = crops.indexOf(crop);
    if (temp1Max > maxTemp[idx] ||
        temp2Max > maxTemp[idx] ||
        temp3Max > maxTemp[idx] ||
        temp4Max > maxTemp[idx] ||
        temp5Max > maxTemp[idx] ||
        temp6Max > maxTemp[idx]) {
      return Icons.arrow_upward_outlined;
    } else if (temp1Min < minTemp[idx] ||
        temp2Min < minTemp[idx] ||
        temp3Min < minTemp[idx] ||
        temp4Min < minTemp[idx] ||
        temp5Min < minTemp[idx] ||
        temp6Min < minTemp[idx]) {
      return Icons.arrow_downward_outlined;
    }
    return Icons.check_circle_outline;
  }

  String tempCompare(String crop) {
    int idx = crops.indexOf(crop);

    if (temp1Max > maxTemp[idx]) {
      return "Temprature is expected to rise.";
    } else if (temp2Max > maxTemp[idx]) {
      return "Temprature is expected to rise in 1 day.";
    } else if (temp3Max > maxTemp[idx]) {
      return "Temprature is expected to rise in 2 days.";
    } else if (temp4Max > maxTemp[idx]) {
      return "Temprature is expected to rise in 3 days.";
    } else if (temp5Max > maxTemp[idx]) {
      return "Temprature is expected to rise in 4 days.";
    } else if (temp6Max > maxTemp[idx]) {
      return "Temprature is expected to rise in 5 days.";
    } else if (temp1Min < minTemp[idx]) {
      return "Temprature is expected to drop.";
    } else if (temp2Min < minTemp[idx]) {
      return "Temprature is expected to drop in 1 day.";
    } else if (temp3Min < minTemp[idx]) {
      return "Temprature is expected to drop in 2 days.";
    } else if (temp4Min < minTemp[idx]) {
      return "Temprature is expected to drop in 3 days.";
    } else if (temp5Min < minTemp[idx]) {
      return "Temprature is expected to drop in 4 days.";
    } else if (temp6Min < minTemp[idx]) {
      return "Temprature is expected to drop in 5 days.";
    }
    return "Weather is Minimal";
  }

  String rainfallStatus(String crop) {
    int idx = crops.indexOf(crop);

    if (rain1 > maxRainfall[idx]) {
      int temp = (maxRainfall[idx] - rain1) as int;
      return temp.toString() + " mm more Rainfall expected";
    } else if (rain2 > maxRainfall[idx]) {
      int temp = (maxRainfall[idx] - rain2) as int;
      return temp.toString() + " mm more Rainfall expected";
    } else if (rain3 > maxRainfall[idx]) {
      int temp = (maxRainfall[idx] - rain3) as int;
      return temp.toString() + " mm more Rainfall expected";
    } else if (rain4 > maxRainfall[idx]) {
      int temp = (maxRainfall[idx] - rain4) as int;
      return temp.toString() + " mm more Rainfall expected";
    } else if (rain5 > maxRainfall[idx]) {
      int temp = (maxRainfall[idx] - rain5) as int;
      return temp.toString() + " mm more Rainfall expected";
    } else if (rain6 > maxRainfall[idx]) {
      int temp = (maxRainfall[idx] - rain6) as int;
      return temp.toString() + " mm more Rainfall expected";
    } else if (rain1 > minRainfall[idx]) {
      int temp = (rain1 - minRainfall[idx]) as int;
      return temp.toString() + " mm less Rainfall expected";
    } else if (rain2 > minRainfall[idx]) {
      int temp = (rain1 - minRainfall[idx]) as int;
      return temp.toString() + " mm less Rainfall expected";
    } else if (rain3 > minRainfall[idx]) {
      int temp = (rain1 - minRainfall[idx]) as int;
      return temp.toString() + " mm less Rainfall expected";
    } else if (rain4 > minRainfall[idx]) {
      int temp = (rain1 - minRainfall[idx]) as int;
      return temp.toString() + " mm less Rainfall expected";
    } else if (rain5 > minRainfall[idx]) {
      int temp = (rain1 - minRainfall[idx]) as int;
      return temp.toString() + " mm less Rainfall expected";
    } else if (rain6 > minRainfall[idx]) {
      int temp = (rain6 - minRainfall[idx]) as int;
      return temp.toString() + " mm less Rainfall expected";
    }
    return 'No Rainfall expected';
  }

  List<int> maxRainfall = [
    0,
    100,
    100,
    60,
    45,
    65,
    150,
    110,
    75,
    200,
    200,
  ];

  List<int> minRainfall = [
    100,
    50,
    50,
    40,
    0,
    60,
    60,
    85,
    70,
    160,
    150,
  ];

  List<String> soil = [
    "Clay, Clay loams",
    "Clay loam ,loam texture",
    "Loamy sand , clay loam",
    "Black cotton soil, sandy loam",
    "Sandy loam soils",
    "Loamy soil",
    "Sandy loam ,clay loam soil",
    "Alluvial, clayey and red sandy loam",
    "Loamy soil, alluvial soils",
    "Clay, sandy loam",
    "Loamy soil",
  ];

  Widget contentFinishedDownload() {
    return CropInformation(
      color: temperatureCompare(cropName),
      tempCompare: tempCompare(cropName),
      name: cropName,
      icon: temperatureIcon(cropName)!,
      rain: rainfallStatus(cropName),
    );
  }

  Widget contentDownloading() {
    return Container(
      margin: const EdgeInsets.all(25),
      child: Column(children: [
        const Text(
          'Loading...',
          style: TextStyle(fontSize: 20),
        ),
        Container(
            margin: const EdgeInsets.only(top: 50),
            child: const Center(child: CircularProgressIndicator()))
      ]),
    );
  }

  Widget contentNotDownloaded() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const <Widget>[
          Text(
            'No Data',
          ),
        ],
      ),
    );
  }

  Widget _resultView() => _state == AppState.FINISHED_DOWNLOADING
      ? contentFinishedDownload()
      : _state == AppState.DOWNLOADING
          ? contentDownloading()
          : contentNotDownloaded();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const SelectCrop())),
              icon: const Icon(
                Icons.change_circle_outlined,
                color: Colors.black,
              ))
        ],
        title: Text(
          city + ", " + country,
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.width / 20,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: AppState.FINISHED_DOWNLOADING == _state
          ? SingleChildScrollView(
              child: Column(
              children: [
                Center(
                    child: CircleAvatar(
                  backgroundColor: Colors.white10,
                  radius: MediaQuery.of(context).size.width / 8,
                  child: Image(
                    width: MediaQuery.of(context).size.width / 3,
                    image: AssetImage(
                      'assets/' + cropName + '.png',
                    ),
                  ),
                )),
                const SizedBox(
                  height: 10,
                ),
                Text(cropName.toUpperCase()),
                const SizedBox(
                  height: 20,
                ),
                _resultView(),
              ],
            ))
          : const Center(
              child: CircularProgressIndicator(),
            ),
      bottomSheet: Image(
        image: const AssetImage('assets/home.png'),
        width: MediaQuery.of(context).size.width,
      ),
    );
  }
}
