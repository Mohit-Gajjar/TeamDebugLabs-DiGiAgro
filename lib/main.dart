import 'package:digiagro/home.dart';
import 'package:digiagro/model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
        home: const Root());
  }
}

class Root extends StatefulWidget {
  const Root({Key? key}) : super(key: key);

  @override
  _RootState createState() => _RootState();
}

class _RootState extends State<Root> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            onTap: () => Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => const Home())),
            child: Container(
              height: 50,
              width: 200,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  color: const Color(0xffF7BB72)),
              child: const Center(
                child: Text(
                  "Get Field Data",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
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
    );
  }
}
