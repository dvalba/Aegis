import 'package:flutter/material.dart';

class DermaTextLogo extends StatelessWidget {
  const DermaTextLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'AEGIS',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          letterSpacing: 6,
          color: Colors.black,
        ),
      ),
    );
  }
}
