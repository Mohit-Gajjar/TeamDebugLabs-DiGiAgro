import 'package:flutter/material.dart';

class CropInformation extends StatefulWidget {
  final Color color;
  final String tempCompare, name;
  final IconData icon;
  final String rain;

  const CropInformation(
      {Key? key,
      required this.color,
      required this.tempCompare,
      required this.name,
      required this.icon,
      required this.rain})
      : super(key: key);

  @override
  CropInformationState createState() => CropInformationState();
}

class CropInformationState extends State<CropInformation> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          widget.icon,
          color: widget.color,
          size: MediaQuery.of(context).size.width / 4,
        ),
        const SizedBox(
          width: 10,
        ),
        Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width / 1.7,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.tempCompare,
                  textAlign: TextAlign.left,
                  style: const TextStyle(fontSize: 18),
                ),
                Text(
                  widget.rain,
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
