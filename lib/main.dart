import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:digiagro/Components/select_crop.dart';
import 'package:digiagro/Sercives/local_database.dart';
import 'package:digiagro/home.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  cropSelection();
  runApp(const MyApp());
}

bool isViewed = false;
void cropSelection() async {
  await LocalDatabase.getViewedPageSelectedSharedPrefs().then((value) {
    if (value == true) {
      isViewed = true;
    }
    if (value == false && value == null) {
      isViewed = false;
    }
  });
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DiGiAgro',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme,
        ),
        primarySwatch: Colors.blue,
      ),
      home: AnimatedSplashScreen(
          splash: const Center(
            child: Image(
              image: AssetImage('assets/logo.png'),
            ),
          ),
          nextScreen: const Root()),
    );
  }
}

class Root extends StatefulWidget {
  const Root({
    Key? key,
  }) : super(key: key);

  @override
  _RootState createState() => _RootState();
}

class _RootState extends State<Root> {
  @override
  Widget build(BuildContext context) {
    return !isViewed
        ? Scaffold(
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 100,
                ),
                Image(
                  image: const AssetImage('assets/logo.png'),
                  width: MediaQuery.of(context).size.width / 3,
                ),
                Center(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      "DiGi",
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color(0xffEC3846)),
                    ),
                    Text(
                      "Agro",
                      style: TextStyle(fontSize: 22, color: Color(0xffCB233B)),
                    )
                  ],
                )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      "Farming ",
                      style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: Color(0xffCB233B)),
                    ),
                    Text(
                      "made ",
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const Text(
                  "Smarter",
                  style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff99AE19)),
                ),
                const SizedBox(
                  height: 30,
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SelectCrop()),
                    );
                    LocalDatabase.saveViewedPageSelectedSharedPrefs(true);
                  },
                  child: Container(
                    height: 50,
                    width: 200,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        color: const Color(0xffF7BB72)),
                    child: const Center(
                      child: Text(
                        "Get Started",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                )
              ],
            ),
            bottomSheet: Image(
              image: const AssetImage('assets/splashIcon.png'),
              width: MediaQuery.of(context).size.width,
            ),
          )
        : const Home();
  }
}
