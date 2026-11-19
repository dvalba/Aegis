import 'dart:io';
import 'package:flutter/material.dart';

class ProfileImagePicker extends StatelessWidget {
  final File? image;
  final VoidCallback onTap;

  const ProfileImagePicker({
    super.key,
    this.image,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
        radius: 60,
        backgroundImage: image != null ? FileImage(image!) : null,
        backgroundColor: const Color(0xFFF0F0F0),
        child: image == null
            ? const Icon(Icons.person, size: 60, color: Colors.grey)
            : null,
      ),
    );
  }
}
