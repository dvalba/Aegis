// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../configs/dynamic_elements/dropdown_items.dart';
import '../../provider/records/image_manager_provider.dart';
import '../records/image_selection_preview.dart';
import 'expandable_menu_widget.dart';

class CustomExpandableMenu extends ConsumerWidget {
  
  final bool showMenu;
  final ImageType type;
  const CustomExpandableMenu({super.key, 
    required this.showMenu,
    required this.type,
  });
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final imagesState = ref.watch(imageManagerProvider);
    final colors = Theme.of(context).colorScheme;
    return Column(children: [
       ExpandableMenuWidget.withGalleryCameraButtons(
          showMenu: showMenu,
          menuColor: Colors.white,
          iconButtonColor: colors.primary,
          onPhotoPressed: () async {
            await ref.read(imageManagerProvider.notifier).pickImageFromGallery(type);
            
          },
          onCameraPressed: () async {
            await ref.read(imageManagerProvider.notifier).pickImageFromCamera(type);
          },
        ),
        ImageSelectionPreview(
            images: imagesState.images,
            onRemoveImage: ref.read(imageManagerProvider.notifier).removeImage,
            onCropperImage:ref.read(imageManagerProvider.notifier).cropImage),
    ]);
  }
}
