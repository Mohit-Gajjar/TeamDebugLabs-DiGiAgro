import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  _launchURLWebsite() async {
    await launchUrl(Uri.parse("https://openweathermap.org/api"),
        mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "About Us",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Image(width: 100, image: AssetImage('assets/logo_db.png')),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Project by Team DebugLabs",
              style: TextStyle(fontSize: 30, color: Colors.black),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 10,
            ),
            const SelectableText(
              "Contact: debuglabs.io@gmail.com",
              style: TextStyle(color: Colors.black),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Weather Data Source",
              style: TextStyle(fontSize: 30, color: Colors.black),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "https://openweathermap.org/",
              style: TextStyle(color: Colors.black),
            ),
            const SizedBox(
              height: 10,
            ),
            const SizedBox(
              width: 200,
              child: Text(
                "Simple and fast and free weather API from OpenWeatherMap you have access to current weather data, hourly, 5- and 16-day forecasts.",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextButton(
                onPressed: _launchURLWebsite, child: const Text("Website")),
          ],
        ),
      ),
    );
  }
}
