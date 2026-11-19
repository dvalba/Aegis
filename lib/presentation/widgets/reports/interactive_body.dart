// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_drawing/path_drawing.dart';
import 'package:xml/xml.dart';

import '../../provider/records/lesion_form_provider.dart';
import '../../provider/records/selected_region_provider.dart';

class InteractiveBody extends StatelessWidget {
  final bool
      isFace; // Indica si se debe mostrar la cara (true) o el cuerpo (false).
  final bool
      isFront; // Indica si se debe mostrar la parte frontal (true) o trasera (false).

  const InteractiveBody({
    super.key,
    required this.isFace,
    required this.isFront,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350, // Altura fija
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 40), // Espaciado
          if (isFace) ...[
            InteractiveParts.frontFace().copyWithKey(key: UniqueKey()),
            SizedBox(height: 20),
            InteractiveParts.sideFace().copyWithKey(key: UniqueKey()),
          ] else
            isFront
                ? InteractiveParts.frontBody().copyWithKey(key: UniqueKey())
                : InteractiveParts.backBody().copyWithKey(key: UniqueKey()),
        ],
      ),
    );
  }
}

class InteractiveParts extends ConsumerStatefulWidget {
  final String path;
  final Offset offset; // Eliminamos el valor por defecto aquí.
  final double width;
  final double height;
  final String Function(String id) idToType;
  final Color Function(String selectedRegionType, Region region) selectColor;
  final Color color;

  InteractiveParts({
    super.key,
    required this.path,
    Offset? offset, // Permitimos que sea nulo para usar un valor por defecto.
    required this.width,
    required this.height,
    required this.idToType,
    required this.selectColor,
    required this.color,
  }) : offset = offset ?? Offset(0, 0);
  InteractiveParts copyWithKey({Key? key}) {
    return InteractiveParts(
      key: key,
      path: path,
      offset: offset,
      width: width,
      height: height,
      idToType: idToType,
      selectColor: selectColor,
      color: color,
    );
  }

  @override
  ConsumerState<InteractiveParts> createState() => _InteractivePartsState();

  factory InteractiveParts.frontBody() {
    return InteractiveParts(
      path: "assets/body/front_body.svg",
      idToType: frontBodyIdToType, // Asegúrate de definir esta función.
      selectColor: selectFrontBodyColor, // Asegúrate de definir esta función.
      width: 130,
      height: 305,
      color: Color.fromARGB(31, 172, 123, 123),
    );
  }
  factory InteractiveParts.backBody() {
    return InteractiveParts(
      path: "assets/body/back_body.svg",
      idToType: backBodyIdToType,
      selectColor: selectBackBodyColor,
      width: 130,
      height: 305,
      color: Color.fromARGB(31, 172, 123, 123),
    );
  }
  factory InteractiveParts.sideFace() {
    return InteractiveParts(
      path: "assets/body/side_face.svg",
      idToType: faceIdToType,
      selectColor: selectFaceColor,
      width: 160,
      height: 160,
      color: Colors.white54,
    );
  }
  factory InteractiveParts.frontFace() {
    return InteractiveParts(
      path: " assets/body/front_face.svg",
      idToType: faceIdToType,
      selectColor: selectFaceColor,
      width: 160,
      height: 160,
      color: Colors.white54,
    );
  }
}

class Region {
  final String id;
  final String path;
  final String Function(String id) idToType;

  Region({
    required this.id,
    required this.path,
    required this.idToType,
  });

  String get type => idToType(id);
}

class _InteractivePartsState extends ConsumerState<InteractiveParts> {
  List<Region> regions = [];

  @override
  void initState() {
    super.initState();
    loadRegions().then((data) {
      setState(() {
        regions = data;
      });
    });
  }

  Future<List<Region>> loadRegions() async {
    final content = await rootBundle.loadString(widget.path);
    final document = XmlDocument.parse(content);
    final paths = document.findAllElements("path");

    return paths
        .where((item) => item.getAttribute('id')?.isNotEmpty ?? false)
        .map((item) {
      final partId = item.getAttribute('id') ?? '';
      final partPath = item.getAttribute('d') ?? '';
      return Region(id: partId, path: partPath, idToType: widget.idToType);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: Container(
        decoration: BoxDecoration(
          color: widget.color,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Stack(
          children: regions.map((region) => _getRegionImage(region)).toList(),
        ),
      ),
    );
  }

  void _onRegionTap(Region region) {
    ref.read(selectedRegionProvider.notifier).toggleRegion(region.type);

    ref.read(lesionFormProvider.notifier).updateLocation(location: region.type);
  }

  Widget _getRegionImage(Region region) {
    final selectedRegion = ref.watch(selectedRegionProvider);
    return ClipPath(
      clipper: RegionClipper(
        svgPath: region.path,
        translation: widget.offset,
      ),
      child: GestureDetector(
        onTap: () => _onRegionTap(region),
        child: Container(
          color: widget.selectColor(selectedRegion ?? '', region),
        ),
      ),
    );
  }
}

class RegionClipper extends CustomClipper<Path> {
  final String svgPath;
  final Offset translation;

  RegionClipper({
    required this.svgPath,
    required this.translation,
  });

  @override
  Path getClip(Size size) {
    final path = parseSvgPathData(svgPath);
    final matrix = Matrix4.identity()
      ..translate(translation.dx, translation.dy);
    return path.transform(matrix.storage);
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

//---
String faceIdToType(String id) {
  if (id.startsWith('outline')) return 'outline';
  if (id.startsWith('low-risk')) return 'low_risk';
  if (id.startsWith('medium-risk')) return 'medium_risk';
  if (id.startsWith('high-risk')) return 'high_risk';
  return 'unknown';
}

String frontBodyIdToType(String id) {
  if (id.startsWith('outline')) return 'outline';
  if (id.startsWith('Right_Shoulder')) return 'right_shoulder';
  if (id.startsWith('Left_Shoulder')) return 'left_shoulder';
  if (id.startsWith('Right_Arm')) return 'right_arm';
  if (id.startsWith('Left_Arm')) return 'left_arm';
  if (id.startsWith('Right_Forearm')) return 'right_forearm';
  if (id.startsWith('Left_Forearm')) return 'left_forearm';
  if (id.startsWith('Right_Hand')) return 'right_hand';
  if (id.startsWith('Left_Hand')) return 'left_hand';
  if (id.startsWith('Right_Thigh')) return 'right_thigh';
  if (id.startsWith('Left_Thigh')) return 'left_thigh';
  if (id.startsWith('Right_Knee')) return 'right_knee';
  if (id.startsWith('Left_Knee')) return 'left_knee';
  if (id.startsWith('Right_Lower_Leg')) return 'right_lower_leg';
  if (id.startsWith('Left_Lower_Leg')) return 'left_lower_leg';
  if (id.startsWith('Right_Foot')) return 'right_foot';
  if (id.startsWith('Left_Foot')) return 'left_foot';
  if (id.startsWith('Face')) return 'face';
  if (id.startsWith('Neck')) return 'neck';
  if (id.startsWith('Chest')) return 'chest';
  if (id.startsWith('Abdomen')) return 'abdomen';
  if (id.startsWith('Pelvic')) return 'pelvic';
  // Fallback for unrecognized IDs
  return 'unknown';
}

String backBodyIdToType(String id) {
  if (id.startsWith('outline')) return 'outline';
  if (id.startsWith('Back_Head')) return 'back_head';
  if (id.startsWith('Upper_Back')) return 'upper_back';
  if (id.startsWith('Middle_Back')) return 'middle_back';
  if (id.startsWith('Lower_Back')) return 'lower_back';
  if (id.startsWith('Left_Shoulder')) return 'left_shoulder';
  if (id.startsWith('Right_Shoulder')) return 'right_shoulder';
  if (id.startsWith('Left_Arm')) return 'left_arm';
  if (id.startsWith('Right_Arm')) return 'right_arm';
  if (id.startsWith('Left_Elbow')) return 'left_elbow';
  if (id.startsWith('Right_Elbow')) return 'right_elbow';
  if (id.startsWith('Left_Forearm')) return 'left_forearm';
  if (id.startsWith('Right_Forearm')) return 'right_forearm';
  if (id.startsWith('Left_Hand')) return 'left_hand';
  if (id.startsWith('Right_Hand')) return 'right_hand';
  if (id.startsWith('Glute')) return 'glute';
  if (id.startsWith('Left_Thigh')) return 'left_thigh';
  if (id.startsWith('Right_Thigh')) return 'right_thigh';
  if (id.startsWith('Left_Popliteal')) return 'left_popliteal';
  if (id.startsWith('Right_Popliteal')) return 'right_popliteal';
  if (id.startsWith('Left_Lower_Leg')) return 'left_lower_leg';
  if (id.startsWith('Right_Lower_Leg')) return 'right_lower_leg';
  if (id.startsWith('Left_Foot')) return 'left_foot';
  if (id.startsWith('Right_Foot')) return 'right_foot';
  // Fallback para IDs no reconocidos.
  return 'unknown';
}
//---

Color selectFaceColor(String selectedRegionType, Region region) {
  switch (region.type) {
    case 'outline':
      return Colors.black;
    case 'low_risk':
      return selectedRegionType == 'low_risk'
          ? const Color.fromARGB(255, 173, 169, 252)
          : const Color.fromARGB(255, 211, 209, 255);
    case 'medium_risk':
      return selectedRegionType == 'medium_risk'
          ? const Color.fromARGB(255, 253, 245, 125)
          : const Color.fromARGB(255, 255, 250, 180);
    case 'high_risk':
      return selectedRegionType == 'high_risk'
          ? const Color.fromARGB(255, 255, 73, 70)
          : const Color.fromRGBO(240, 105, 102, 1.0);
    default:
      return Colors.grey;
  }
}

Color selectFrontBodyColor(String selectedRegionType, Region region) {
  switch (region.type) {
    case 'outline':
      return Colors.black;
    case 'right_shoulder':
    case 'left_shoulder':
      return selectedRegionType == region.type
          ? const Color.fromARGB(255, 129, 122, 255)
          : const Color.fromARGB(255, 211, 209, 255);
    case 'right_arm':
    case 'left_arm':
      return selectedRegionType == region.type
          ? const Color.fromARGB(255, 129, 122, 255)
          : const Color.fromARGB(255, 211, 209, 255);
    case 'right_forearm':
    case 'left_forearm':
      return selectedRegionType == region.type
          ? const Color.fromARGB(255, 129, 122, 255)
          : const Color.fromARGB(255, 211, 209, 255);
    case 'right_hand':
    case 'left_hand':
      return selectedRegionType == region.type
          ? const Color.fromARGB(255, 129, 122, 255)
          : const Color.fromARGB(255, 211, 209, 255);
    case 'right_thigh':
    case 'left_thigh':
      return selectedRegionType == region.type
          ? const Color.fromARGB(255, 129, 122, 255)
          : const Color.fromARGB(255, 211, 209, 255);
    case 'right_knee':
    case 'left_knee':
      return selectedRegionType == region.type
          ? const Color.fromARGB(255, 129, 122, 255)
          : const Color.fromARGB(255, 211, 209, 255);
    case 'right_lower_leg':
    case 'left_lower_leg':
      return selectedRegionType == region.type
          ? const Color.fromARGB(255, 129, 122, 255)
          : const Color.fromARGB(255, 211, 209, 255);
    case 'right_foot':
    case 'left_foot':
      return selectedRegionType == region.type
          ? const Color.fromARGB(255, 129, 122, 255)
          : const Color.fromARGB(255, 211, 209, 255);
    case 'face':
      return selectedRegionType == region.type
          ? const Color.fromARGB(255, 129, 122, 255)
          : const Color.fromARGB(255, 211, 209, 255);
    case 'neck':
      return selectedRegionType == region.type
          ? const Color.fromARGB(255, 129, 122, 255)
          : const Color.fromARGB(255, 211, 209, 255);
    case 'chest':
      return selectedRegionType == region.type
          ? const Color.fromARGB(255, 129, 122, 255)
          : const Color.fromARGB(255, 211, 209, 255);
    case 'abdomen':
      return selectedRegionType == region.type
          ? const Color.fromARGB(255, 129, 122, 255)
          : const Color.fromARGB(255, 211, 209, 255);
    case 'pelvic':
      return selectedRegionType == region.type
          ? const Color.fromARGB(255, 129, 122, 255)
          : const Color.fromARGB(255, 211, 209, 255);
    default:
      return Colors.grey;
  }
}

Color selectBackBodyColor(String selectedRegionType, Region region) {
  switch (region.type) {
    case 'outline':
      return Colors.black;
    case 'back_head':
      return selectedRegionType == region.type
          ? const Color.fromARGB(255, 129, 122, 255)
          : const Color.fromARGB(255, 211, 209, 255);
    case 'upper_back':
    case 'middle_back':
    case 'lower_back':
      return selectedRegionType == region.type
          ? const Color.fromARGB(255, 129, 122, 255)
          : const Color.fromARGB(255, 211, 209, 255);
    case 'left_shoulder':
    case 'right_shoulder':
      return selectedRegionType == region.type
          ? const Color.fromARGB(255, 129, 122, 255)
          : const Color.fromARGB(255, 211, 209, 255);
    case 'left_arm':
    case 'right_arm':
      return selectedRegionType == region.type
          ? const Color.fromARGB(255, 129, 122, 255)
          : const Color.fromARGB(255, 211, 209, 255);
    case 'left_elbow':
    case 'right_elbow':
      return selectedRegionType == region.type
          ? const Color.fromARGB(255, 129, 122, 255)
          : const Color.fromARGB(255, 211, 209, 255);
    case 'left_forearm':
    case 'right_forearm':
      return selectedRegionType == region.type
          ? const Color.fromARGB(255, 129, 122, 255)
          : const Color.fromARGB(255, 211, 209, 255);
    case 'left_hand':
    case 'right_hand':
      return selectedRegionType == region.type
          ? const Color.fromARGB(255, 129, 122, 255)
          : const Color.fromARGB(255, 211, 209, 255);
    case 'glute':
      return selectedRegionType == region.type
          ? const Color.fromARGB(255, 129, 122, 255)
          : const Color.fromARGB(255, 211, 209, 255);
    case 'left_thigh':
    case 'right_thigh':
      return selectedRegionType == region.type
          ? const Color.fromARGB(255, 129, 122, 255)
          : const Color.fromARGB(255, 211, 209, 255);
    case 'left_popliteal':
    case 'right_popliteal':
      return selectedRegionType == region.type
          ? const Color.fromARGB(255, 129, 122, 255)
          : const Color.fromARGB(255, 211, 209, 255);
    case 'left_lower_leg':
    case 'right_lower_leg':
      return selectedRegionType == region.type
          ? const Color.fromARGB(255, 129, 122, 255)
          : const Color.fromARGB(255, 211, 209, 255);
    case 'left_foot':
    case 'right_foot':
      return selectedRegionType == region.type
          ? const Color.fromARGB(255, 129, 122, 255)
          : const Color.fromARGB(255, 211, 209, 255);
    default:
      return Colors.grey;
  }
}
