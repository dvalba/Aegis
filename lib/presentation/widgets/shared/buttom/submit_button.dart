import 'package:flutter/material.dart';

class SubmitButton extends StatelessWidget {
  final String label;
  final Color backgroundColor;
  final Color textColor;
  final EdgeInsetsGeometry padding;
  final void Function()? onPressed;
  final double borderRadius;

  const SubmitButton(
      {super.key,
      required this.label,
      required this.backgroundColor,
      required this.textColor,
      this.padding =  const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
      this.borderRadius = 24,
      this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed:onPressed,
      style: ElevatedButton.styleFrom(
        padding: padding,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        backgroundColor: backgroundColor,
      ),
      child: Text(
        label,
        style: TextStyle(
          color: textColor,
          fontSize: 16,
        ),
      ),
    );
  }
}
