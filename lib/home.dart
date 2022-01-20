// ignore_for_file: constant_identifier_names
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:location/location.dart';
import 'package:weather/weather.dart';

enum AppState { NOT_DOWNLOADED, DOWNLOADING, FINISHED_DOWNLOADING }

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  LocationData? _locationData;
  Location location = Location();
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
    print(_locationData!.latitude);
    print(_locationData!.longitude);
  }

  WeatherFactory ws = WeatherFactory('095487694b8c8643e6325b844b6dcdac');
  List<Weather> _data = [];
  AppState _state = AppState.NOT_DOWNLOADED;
  double? lat, lon;

  @override
  void initState() {
    super.initState();
    _getPermissons();

    queryForecast();
  }

  void queryForecast() async {
    setState(() {
      _state = AppState.DOWNLOADING;
    });

    List<Weather> forecasts = await ws.fiveDayForecastByLocation(lat!, lon!);
    setState(() {
      _data = forecasts;
      _state = AppState.FINISHED_DOWNLOADING;
    });
  }

  void queryWeather() async {
    setState(() {
      _state = AppState.DOWNLOADING;
    });

    Weather weather = await ws.currentWeatherByLocation(lat!, lon!);
    setState(() {
      _data = [weather];
      _state = AppState.FINISHED_DOWNLOADING;
    });
  }

  Widget contentFinishedDownload() {
    return Center(
      child: ListView.separated(
        itemCount: _data.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_data[index].toString()),
          );
        },
        separatorBuilder: (context, index) {
          return const Divider();
        },
      ),
    );
  }

  Widget contentDownloading() {
    return Container(
      margin: const EdgeInsets.all(25),
      child: Column(children: [
        const Text(
          'Fetching Weather...',
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
            'Press the button to download the Weather forecast',
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

  Widget _buttons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          margin: const EdgeInsets.all(5),
          child: TextButton(
            child: const Text(
              'Fetch weather',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: queryWeather,
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.blue)),
          ),
        ),
        Container(
          margin: const EdgeInsets.all(5),
          child: TextButton(
            child: const Text(
              'Fetch forecast',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: queryForecast,
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.blue)),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Expanded(child: _resultView()),
      // SingleChildScrollView(
      //   child: Column(
      //     children: [
      //       const SizedBox(
      //         height: 80,
      //       ),
      //       Center(
      //         child: Column(
      //           children:  [
      //             Text(
      //               place + ", " + divistion,
      //               style: TextStyle(
      //                 fontSize: MediaQuery.of(context).size.width / 20,
      //                 fontWeight: FontWeight.bold,
      //               ),
      //             ),
      //             Text(
      //               state + ", " + country,
      //               style: TextStyle(
      //                 fontSize: MediaQuery.of(context).size.width / 20,
      //               ),
      //             ),

      //           ],
      //         ),
      //       ),
      //       const SizedBox(
      //         height: 20,
      //       ),
      //     ],
      //   ),
      // ),
      bottomSheet: Image(
        image: const AssetImage('assets/home.png'),
        width: MediaQuery.of(context).size.width,
      ),
    );
  }
}
