import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ProgressBar extends StatefulWidget {
  double percentage;
  double width;
  double height;

  ProgressBar(
      {@required this.width, @required this.height, @required this.percentage});
  @override
  _ProgressBarState createState() => _ProgressBarState();
}

class _ProgressBarState extends State<ProgressBar> {
  double progressValue;
  double progressPercent;

// progress_bar_get_method
  double getProgress() {
    setState(() {
      progressValue = (widget.percentage * widget.width) / 100;
    });
    return progressValue;
  }

// progress_percentage_method
  double getProgressPrecent() {
    setState(() {
      progressPercent = (progressValue / widget.width) * 100;
    });
    return progressPercent;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(0),
        color: Colors.black26,
      ),
      height: widget.height,
      width: widget.width,
      alignment: Alignment.centerLeft,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(0),
          color: Theme.of(context).primaryColor,
        ),
        height: widget.height,
        alignment: Alignment.centerRight,
        width: getProgress(),
        child: Text(
          getProgressPrecent().toInt().toString() + "%",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w300,
            fontSize: 8,
          ),
        ),
      ),
    );
  }
}
