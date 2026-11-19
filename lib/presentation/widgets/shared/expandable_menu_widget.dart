import 'package:flutter/material.dart';

import 'buttom/circular_icon_botton.dart';

class ExpandableMenuWidget extends StatelessWidget {
  final bool showMenu;
  final Color menuColor;
  final double height;
  final List<Widget> children;

  // Constructor principal (flexible)
  const ExpandableMenuWidget({
    super.key,
    required this.showMenu,
    required this.menuColor,
    required this.height,
    required this.children,
  });

  // Constructor personalizado con botones de galería y cámara
  ExpandableMenuWidget.withGalleryCameraButtons({
    super.key,
    required this.showMenu,
    required this.menuColor,
    required Color iconButtonColor,
    required VoidCallback onPhotoPressed,
    required VoidCallback onCameraPressed,
  })  : children = [
          SizedBox(width: 16),
          CircularIconButton(
            icon: Icons.photo_library_rounded,
            tooltip: 'Open Photo Library',
            onPressed: onPhotoPressed,
            backgroundColor: iconButtonColor,
          ),
          SizedBox(width: 16),
          CircularIconButton(
            icon: Icons.camera_alt_rounded,
            tooltip: 'Open Camera',
            onPressed: onCameraPressed,
            backgroundColor: iconButtonColor,
          ),
        ],
        height = 60.0;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      height: showMenu ? height : 0.0,
      color: menuColor,
      child: showMenu
          ? Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: children,
            )
          : null,
    );
  }
}
