import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NavigationTextButton extends StatelessWidget {
  final String text;
  final String routeName;
  final Color textColor;
  final double fontSize;
  final TextDecoration decoration;

  const NavigationTextButton({
    super.key,
    required this.text,
    required this.routeName,
    this.textColor = Colors.purple,
    this.fontSize = 16.0,
    this.decoration = TextDecoration.underline,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        context.pushNamed(routeName);
      },
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontSize: fontSize,
          decoration: decoration,
        ),
      ),
    );
  }
}
