import 'package:demo_movie/src/utils/utils.dart';
import 'package:flutter/material.dart';

class MovieAppBar extends StatefulWidget {
  final String? title;
  final Widget? leftIcon;
  final Widget? rightIcon;
  final Function? onTapLeftIcon;
  final Function? onTapRightIcon;
  const MovieAppBar(
      {Key? key,
      this.title,
      this.onTapLeftIcon,
      this.leftIcon,
      this.onTapRightIcon,
      this.rightIcon})
      : super(key: key);

  @override
  _MovieAppBarState createState() => _MovieAppBarState();
}

class _MovieAppBarState extends State<MovieAppBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: screenWidth(context, dividedBy: 1),
        padding: EdgeInsets.symmetric(horizontal: screenWidth(context, dividedBy:30)),
        child: Row(
          children: [
            if (widget.leftIcon != null)
              GestureDetector(
                  onTap: () {
                    widget.onTapLeftIcon!();
                  },
                  child: widget.leftIcon!),
            if (widget.leftIcon == null)
              GestureDetector(
                  onTap: () {
                    pop(context);
                  },
                  child: Icon(Icons.arrow_back_ios_sharp, color: Colors.white)),
            Spacer(),
            Text(
              widget.title ?? "",
              style: Theme.of(context).textTheme.displayLarge,
              // const TextStyle(
              //     fontSize: 20.0,
              //     color: Colors.white,
              //     fontWeight: FontWeight.bold),
            ),
            Spacer(),
            if (widget.rightIcon != null)
              GestureDetector(
                  onTap: () {
                    widget.onTapRightIcon!();
                  },
                  child: widget.rightIcon!),
          ],
        ));
  }
}
