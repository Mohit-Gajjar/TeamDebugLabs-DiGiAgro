
import 'package:digiagro/Sercives/local_database.dart';
import 'package:digiagro/home.dart';
import 'package:flutter/material.dart';

class SelectCrop extends StatefulWidget {
  const SelectCrop({Key? key}) : super(key: key);

  @override
  _SelectCropState createState() => _SelectCropState();
}

class _SelectCropState extends State<SelectCrop> {
  void selectCrop(String crop) {
    LocalDatabase.saveCropIsSelectedSharedPrefs(true);
    LocalDatabase.saveCropSharedPrefs(crop);
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const Home()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: const Text(
          "Select Crop",
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: GridView.count(
            crossAxisCount: 3,
            crossAxisSpacing: 4.0,
            mainAxisSpacing: 8.0,
            children: List.generate(crops.length, (index) {
              return Center(
                child: GestureDetector(
                    onTap: () => selectCrop(crops[index]),
                    child: SelectCard(choice: choices[index])),
              );
            })),
      ),
      bottomSheet: Row(
        children: [
          const Spacer(),
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'Cancel',
                style: TextStyle(
                    color: Colors.red,
                    decoration: TextDecoration.underline,
                    fontSize: 16),
              )),
        ],
      ),
    );
  }
}

const List<String> crops = [
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
const List<String> images = [
  "assets/Rice.png",
  "assets/Wheat.png",
  "assets/Maize.png",
  "assets/Bajra.png",
  "assets/Jowar.png",
  "assets/soya bean.png",
  "assets/groundnut.png",
  "assets/cotton.png",
  "assets/Sugarcane.png",
  "assets/Jute.png",
  "assets/Coffee.png",
];

const List<Choice> choices = <Choice>[
  Choice(title: 'Rice', image: 'assets/Rice.png'),
  Choice(title: 'Wheat', image: 'assets/Wheat.png'),
  Choice(title: 'Maize', image: 'assets/Maize.png'),
  Choice(title: 'Jowar', image: 'assets/Jowar.png'),
  Choice(title: 'Bajra', image: 'assets/Bajra.png'),
  Choice(title: 'Soya Bean', image: 'assets/soya bean.png'),
  Choice(title: 'Groundnut', image: 'assets/groundnut.png'),
  Choice(title: 'Cotton', image: 'assets/cotton.png'),
  Choice(title: 'Sugarcane', image: 'assets/Sugarcane.png'),
  Choice(title: 'Jute', image: 'assets/Jute.png'),
  Choice(title: 'Coffee', image: 'assets/Coffee.png'),
];

class Choice {
  final String title;
  final String image;
  const Choice({required this.title, required this.image});
}

class SelectCard extends StatelessWidget {
  final Choice choice;
  const SelectCard({
    Key? key,
    required this.choice,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      height: 400,
      decoration: BoxDecoration(
          color: Colors.cyan, borderRadius: BorderRadius.circular(16)),
      child: Center(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                  child: CircleAvatar(
                maxRadius: 30,
                backgroundImage: AssetImage(choice.image),
                backgroundColor: Colors.white54,
              )),
              Text(
                choice.title,
              ),
            ]),
      ),
    );
  }
}
