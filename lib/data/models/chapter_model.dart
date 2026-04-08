import 'package:equatable/equatable.dart';

class ChapterImages extends Equatable {
  final String chapterEndpoint;
  final List<String> images;

  const ChapterImages({
    required this.chapterEndpoint,
    required this.images,
  });

  factory ChapterImages.fromJson(Map<String, dynamic> json) {
    var rawList = json['chapter_image'] as List? ?? [];
    List<String> imagesList = rawList.map((i) => i['chapter_image_link'].toString()).toList();
    
    return ChapterImages(
      chapterEndpoint: json['chapter_endpoint'] ?? '',
      images: imagesList,
    );
  }

  @override
  List<Object?> get props => [chapterEndpoint, images];
}
