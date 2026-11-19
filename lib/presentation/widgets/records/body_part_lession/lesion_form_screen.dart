import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BodyPartsView extends StatefulWidget {
  const BodyPartsView({super.key});

  @override
  BodyPartsViewState createState() => BodyPartsViewState();
}

// Mapa actualizado con posiciones y medidas
final Map<String, Map<String, double>> svgMap = {
  'Abdomen': {'width_px': 39.55, 'height_px': 24.52, 'left': 36, 'top': 90},
  'Face': {'width_px': 31.06, 'height_px': 31.20, 'left': 40, 'top': 10},
  'LeftArm': {'width_px': 21.61, 'height_px': 63.63, 'left': 15, 'top': 49},
  'LeftLeg': {'width_px': 21.21, 'height_px': 71.09, 'left': 33, 'top': 110},
  'Neck': {'width_px': 15.74, 'height_px': 5.49, 'left': 47, 'top': 40},
  'RightArm': {'width_px': 21.61, 'height_px': 63.63, 'left': 74, 'top': 48},
  'Torso': {'width_px': 39.13, 'height_px': 45.51, 'left': 36, 'top': 45},
  'RightLeg': {'width_px': 21.21, 'height_px': 71.09, 'left': 57, 'top': 110},
  'Skull': {'width_px': 30.09, 'height_px': 11.96, 'left': 40, 'top': 0},
};

class BodyPartsViewState extends State<BodyPartsView> {
  final Map<String, Color?> _bodyPartColors = {
    for (var part in svgMap.keys) part: null,
  };

  void _onPartTap(String part) {
    setState(() {
      // Cambiar el color basado en el estado actual
      if (_bodyPartColors[part] == null) {
        _bodyPartColors[part] = Colors.pink; // Si es null, poner rosa
      } else if (_bodyPartColors[part] == Colors.pink) {
        _bodyPartColors[part] = Colors.grey; // Si es rosa, poner gris
      } else if (_bodyPartColors[part] == Colors.grey) {
        _bodyPartColors[part] = Colors.pink; // Si es gris, poner rosa
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Body Parts Interaction'),
        backgroundColor: Colors.teal,
      ),
      body: Center(
        child: Container(
          width: 85, // Tamaño total del cuerpo
          height: 180, // Tamaño total del cuerpo
          color: Colors.grey[300], // Fondo gris
          child: Stack(
            children: svgMap.entries.map((entry) {
              final part = entry.key;
              final dimensions = entry.value;

              return _positionBodyPart(
                part,
                'assets/body/$part.svg',
                left: dimensions['left']!,
                top: dimensions['top']!,
                width: dimensions['width_px']!,
                height: dimensions['height_px']!,
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  Widget _positionBodyPart(String part, String assetPath,
      {required double left,
      required double top,
      required double width,
      required double height}) {
    return Positioned(
      left: left,
      top: top,
      child: GestureDetector(
        onTap: () => _onPartTap(part),
        child: SvgPicture.asset(
          assetPath,
          width: width,
          height: height,
          color: _bodyPartColors[part], // Cambia de color al hacer clic
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}


// import 'package:flutter/material.dart';

// class AddLesionView extends StatefulWidget {
//   @override
//   _AddLesionViewState createState() => _AddLesionViewState();
// }

// class _AddLesionViewState extends State<AddLesionView> {
//   // Mapa para rastrear las áreas seleccionadas
//   Map<String, bool> selectedAreas = {
//     'head': false,
//     'torso': false,
//     'leftArm': false,
//     'rightArm': false,
//     'leftLeg': false,
//     'rightLeg': false,
//   };

//   void toggleSelection(String area) {
//     setState(() {
//       selectedAreas[area] = !(selectedAreas[area] ?? false);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Select Area of Lesion'),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: Center(
//               child: GestureDetector(
//                 onTapDown: (details) {
//                   // Detectar las coordenadas del toque
//                   print("Tap at: ${details.localPosition}");

//                   // Verificar la parte del cuerpo tocada (esto depende de las coordenadas)
//                   if (_isInsideArea(details.localPosition, 'head')) {
//                     toggleSelection('head');
//                   } else if (_isInsideArea(details.localPosition, 'torso')) {
//                     toggleSelection('torso');
//                   } else if (_isInsideArea(details.localPosition, 'leftArm')) {
//                     toggleSelection('leftArm');
//                   } else if (_isInsideArea(details.localPosition, 'rightArm')) {
//                     toggleSelection('rightArm');
//                   } else if (_isInsideArea(details.localPosition, 'leftLeg')) {
//                     toggleSelection('leftLeg');
//                   } else if (_isInsideArea(details.localPosition, 'rightLeg')) {
//                     toggleSelection('rightLeg');
//                   }
//                 },
//                 child: CustomPaint(
//                   size: Size(200, 400), // Tamaño del área del cuerpo
//                   painter: BodyPainter(selectedAreas),
//                 ),
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: ElevatedButton(
//               onPressed: () {
//                 print("Selected areas: $selectedAreas");
//               },
//               child: Text('Submit Selection'),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   bool _isInsideArea(Offset position, String area) {
//     // Lógica para verificar si el toque está dentro de un área
//     // Esto dependerá de las coordenadas de las partes del cuerpo

//     // Definir las áreas del cuerpo como Rectángulos o elipses
//     final head = Rect.fromCircle(
//       center: Offset(100, 40),
//       radius: 30,
//     );
    
//     // Parte vertical de la T (torso principal)
//     final torsoVertical = Rect.fromLTRB(80, 80, 120, 200);

//     // Parte horizontal de la T (los hombros)
//     final torsoHorizontal = Rect.fromLTRB(60, 80, 140, 100);

//     final leftArm = Rect.fromLTRB(20, 80, 60, 150);
//     final rightArm = Rect.fromLTRB(140, 80, 180, 150);
//     final leftLeg = Rect.fromLTRB(80, 200, 110, 300);
//     final rightLeg = Rect.fromLTRB(110, 200, 140, 300);

//     if (area == 'head') {
//       return head.contains(position);
//     } else if (area == 'torso') {
//       // Verificamos si el toque está dentro de la parte vertical o horizontal de la "T"
//       return torsoVertical.contains(position) || torsoHorizontal.contains(position);
//     } else if (area == 'leftArm') {
//       return leftArm.contains(position);
//     } else if (area == 'rightArm') {
//       return rightArm.contains(position);
//     } else if (area == 'leftLeg') {
//       return leftLeg.contains(position);
//     } else if (area == 'rightLeg') {
//       return rightLeg.contains(position);
//     }

//     return false;
//   }
// }

// class BodyPainter extends CustomPainter {
//   final Map<String, bool> selectedAreas;

//   BodyPainter(this.selectedAreas);

//   @override
//   void paint(Canvas canvas, Size size) {
//     final Paint paint = Paint()..style = PaintingStyle.fill;

//     // Definir las áreas del cuerpo usando coordenadas similares al SVG

//     // Cabeza
//     final head = Rect.fromCircle(
//       center: Offset(size.width / 2, size.height * 0.1),
//       radius: size.width * 0.1,
//     );
    
//     // Parte vertical de la T (torso principal)
//     final torsoVertical = Rect.fromLTRB(size.width * 0.4, size.height * 0.2, size.width * 0.6, size.height * 0.6);

//     // Parte horizontal de la T (los hombros)
//     final torsoHorizontal = Rect.fromLTRB(size.width * 0.3, size.height * 0.2, size.width * 0.7, size.height * 0.3);

//     // Brazos y piernas
//     final leftArm = Rect.fromLTRB(size.width * 0.15, size.height * 0.2, size.width * 0.35, size.height * 0.5);
//     final rightArm = Rect.fromLTRB(size.width * 0.65, size.height * 0.2, size.width * 0.85, size.height * 0.5);
//     final leftLeg = Rect.fromLTRB(size.width * 0.4, size.height * 0.6, size.width * 0.5, size.height * 0.9);
//     final rightLeg = Rect.fromLTRB(size.width * 0.5, size.height * 0.6, size.width * 0.6, size.height * 0.9);

//     // Pintar las áreas según la selección
//     paint.color = selectedAreas['head'] == true ? Colors.pink : Colors.grey;
//     canvas.drawOval(head, paint);

//     paint.color = selectedAreas['torso'] == true ? Colors.pink : Colors.grey;
//     // Pintamos la parte vertical y horizontal de la "T"
//     canvas.drawRect(torsoVertical, paint);
//     canvas.drawRect(torsoHorizontal, paint);

//     paint.color = selectedAreas['leftArm'] == true ? Colors.pink : Colors.grey;
//     canvas.drawRect(leftArm, paint);

//     paint.color = selectedAreas['rightArm'] == true ? Colors.pink : Colors.grey;
//     canvas.drawRect(rightArm, paint);

//     paint.color = selectedAreas['leftLeg'] == true ? Colors.pink : Colors.grey;
//     canvas.drawRect(leftLeg, paint);

//     paint.color = selectedAreas['rightLeg'] == true ? Colors.pink : Colors.grey;
//     canvas.drawRect(rightLeg, paint);
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
// }


