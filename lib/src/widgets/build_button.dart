import 'package:demo_movie/src/utils/constants.dart';
import 'package:demo_movie/src/utils/utils.dart';
import 'package:flutter/material.dart';

class BuildButton extends StatefulWidget {
  final String label;
  final Color? selectedColor;
  final Function onTap;

  const BuildButton(
      {Key? key, required this.label, required this.onTap, this.selectedColor})
      : super(key: key);

  @override
  _BuildButtonState createState() => _BuildButtonState();
}

class _BuildButtonState extends State<BuildButton> {
  bool selected = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selected = true;
        });
        widget.onTap();
      },
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: screenWidth(context, dividedBy: 30),
            vertical: screenHeight(context, dividedBy: 70)),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: widget.selectedColor ?? Constants.colors[3]),
        child: Center(
          child: Text(
            widget.label,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
      ),
    );
  }
}
