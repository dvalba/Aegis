import 'package:isar/isar.dart';

part 'tagged_image.g.dart';

@Collection()
class TaggedImage {
  Id isarId;

  @Index()
  late int lesionId;

  late String imagePath;
  late String tag;

  @Index()
  late bool synced = false;

  TaggedImage({
    Id? imageId,
    required this.imagePath,
    required this.tag,
    this.synced = false,
  }): isarId = imageId ?? Isar.autoIncrement;
}



