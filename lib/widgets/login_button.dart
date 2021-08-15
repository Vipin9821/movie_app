import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  final Function onTap;
  final Color color;
  final String label;
  // final IconData iconData;
  final double width;
  final double height;
  final Color textColor;
  // final Color iconColor;
  final Color borderColor;
  const LoginButton({
    this.borderColor = Colors.black,
    // this.iconColor,
    this.textColor,
    this.height,
    this.width,
    this.color,
    // this.iconData = FontAwesomeIcons.alignRight,
    this.label,
    this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(80),
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: borderColor,
          ),
          borderRadius: BorderRadius.circular(80.0),
          color: color,
        ),
        padding: const EdgeInsets.all(12.0),
        child: Text(
          '$label',
          style: TextStyle(
            color: textColor,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
