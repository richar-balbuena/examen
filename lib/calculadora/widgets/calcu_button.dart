import 'package:flutter/material.dart';

class CalcuButton extends StatelessWidget {
  final Color bgColor;
  final bool big;
  final String text;

  final Function onPressed;

  CalcuButton({
    super.key,
    bgColor,
    this.big = false,
    required this.text,
    required this.onPressed,
  }) : this.bgColor = bgColor ?? Color.fromRGBO(163, 156, 156, 0.565);

  @override
  Widget build(BuildContext context) {
    // button
    final ButtonStyle = TextButton.styleFrom(
      backgroundColor: this.bgColor,
      shape: StadiumBorder(),
    );

    return Container(
      margin: EdgeInsets.only(bottom: 10, right: 5, left: 5),
      child: TextButton(
        style: ButtonStyle,
         child: Container(
          width: this.big ? 150: 65,
          height: 65,
          child: Center(
            child: Text(this.text, style: TextStyle(fontSize: 35, fontWeight: FontWeight.w400),)

          ),
          ),
         onPressed: () => this.onPressed(),
         ),
         );
      
    
  }
}
