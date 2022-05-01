import 'package:flutter/material.dart';

class CalcButton extends StatefulWidget {
  final dynamic value;
  final Color color;
  final bool isBtn;

  CalcButton(this.value, this.color, this.isBtn);

  @override
  _CalcButtonState createState() => _CalcButtonState();
}

class _CalcButtonState extends State<CalcButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 60,
        height: 60,
        color: widget.color,
        padding: EdgeInsets.all(10),
        child: Center(
          child: widget.isBtn == true
              ? widget.value
              : Text(
                  widget.value,
                  style: TextStyle(fontSize: 27),
                ),
        ));
  }
}
