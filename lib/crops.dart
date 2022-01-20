import 'package:digiagro/Components/make_manure.dart';
import 'package:digiagro/Sercives/services.dart';
import 'package:digiagro/Components/crop_profile.dart';
import 'package:flutter/material.dart';

class Crops extends StatefulWidget {
  final String soil;
  const Crops({Key? key, required this.soil}) : super(key: key);

  @override
  _CropsState createState() => _CropsState();
}

class _CropsState extends State<Crops> {
  @override
  void initState() {
    getCropsMethord();
    super.initState();
  }

  Stream? getCropsStream;
  getCropsMethord() {
    Database().getCrops(widget.soil).then((val) {
      getCropsStream = val;
      setState(() {});
    });
  }

  Widget getCropsWidget() {
    return StreamBuilder(
        stream: getCropsStream,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    return CropsTitle(
                      title: snapshot.data.docs[index]["name"],
                      producers: snapshot.data.docs[index]["Producers"],
                      rainfall: snapshot.data.docs[index]["Rainfall"],
                      soil: snapshot.data.docs[index]["Soil"],
                      temperature: snapshot.data.docs[index]["Temperature"],
                      varieties: snapshot.data.docs[index]["Varieties"],
                    );
                  })
              : const Center(
                  child: CircularProgressIndicator(),
                );
        });
  }

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
            'Crops which can grow on your soil',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          )),
      body: getCropsWidget(),
      floatingActionButton: InkWell(
        onTap: () => Navigator.push(context,
            MaterialPageRoute(builder: (context) => const MakeManure())),
        child: Container(
          height: 50,
          width: 200,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              color: const Color(0xffF7BB72)),
          child: const Center(
            child: Text(
              "Make Manure",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}

class CropsTitle extends StatelessWidget {
  final String title, varieties, temperature, soil, rainfall, producers;
  const CropsTitle({
    Key? key,
    required this.title,
    required this.varieties,
    required this.temperature,
    required this.soil,
    required this.rainfall,
    required this.producers,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CropProfile(
                    title: title,
                    varieties: varieties,
                    temperature: temperature,
                    soil: soil,
                    rainfall: rainfall,
                    producers: producers)));
      },
      title: Text(title,
          style: const TextStyle(
              fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black)),
    );
  }
}
