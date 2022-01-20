import 'package:flutter/material.dart';

class CropProfile extends StatefulWidget {
  final String title, varieties, temperature, soil, rainfall, producers;
  const CropProfile(
      {Key? key,
      required this.title,
      required this.varieties,
      required this.temperature,
      required this.soil,
      required this.rainfall,
      required this.producers})
      : super(key: key);

  @override
  _CropProfileState createState() => _CropProfileState();
}

class _CropProfileState extends State<CropProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
          title: const Text(
            'Crops Information',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          )),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              title: const Text(
                'Name',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(widget.title),
            ),
            ListTile(
              title: const Text(
                'Varities',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(widget.varieties),
            ),
            ListTile(
              title: const Text(
                'Temperature',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(widget.temperature),
            ),
            ListTile(
              title: const Text(
                'Soil',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(widget.soil),
            ),
            ListTile(
              title: const Text(
                'Rainfall',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(widget.rainfall),
            ),
            ListTile(
              title: const Text(
                'Producers',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(widget.producers),
            ),
          ],
        ),
      ),
    );
  }
}