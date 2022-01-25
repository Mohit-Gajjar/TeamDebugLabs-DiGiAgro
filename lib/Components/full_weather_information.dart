import 'package:flutter/material.dart';

class FullForecast extends StatefulWidget {
  const FullForecast({Key? key}) : super(key: key);

  @override
  _FullForecastState createState() => _FullForecastState();
}

class _FullForecastState extends State<FullForecast> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Prediction',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: const Center(
        child: Text('This is the test Forecast Page'),
      ),
    );
  }
}
