import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:digiagro/Components/first_time_crop_selection.dart';
import 'package:digiagro/Sercives/local_database.dart';
import 'package:digiagro/home.dart';
import 'package:flutter/gestures.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Components/policy_dialog.dart';
import 'Components/terms_and_conditions_dialog.dart';

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
                          builder: (context) => const FirstSelectCrop()),
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
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(bottom: 50),
                  child: Image(
                    image: const AssetImage('assets/splashIcon.png'),
                    width: MediaQuery.of(context).size.width,
                  ),
                ),
              ],
            ),
            bottomSheet: Container(
              color: Colors.white,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                        text:
                            "By clicking on Get Started button, you are agreeing to our\n",
                        style: const TextStyle(
                            fontWeight: FontWeight.w400, color: Colors.black),
                        children: [
                          TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return const TermsAndConditionsDialog();
                                      });
                                },
                              text: "Terms & Conditions ",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black)),
                          const TextSpan(
                              text: "and ",
                              style: TextStyle(color: Colors.black)),
                          TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return const PolicyDialog();
                                      });
                                },
                              text: "Privacy Policy ",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black)),
                        ]),
                  ),
                ),
              ),
              height: 60,
            ),
          )
        : const Home();
  }
}
