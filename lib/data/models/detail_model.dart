import 'package:equatable/equatable.dart';

class DetailManga extends Equatable {
  final String title;
  final String thumb;
  final String author;
  final String status;
  final String synopsis;
  final List<ChapterInfo> chapter;

  const DetailManga({
    required this.title,
    required this.thumb,
    required this.author,
    required this.status,
    required this.synopsis,
    required this.chapter,
  });

  factory DetailManga.fromJson(Map<String, dynamic> json) {
    var list = json['chapter'] as List? ?? [];
    List<ChapterInfo> chapterList = list.map((i) => ChapterInfo.fromJson(i)).toList();

    return DetailManga(
      title: json['title'] ?? '',
      thumb: json['thumb'] ?? '',
      author: json['author'] ?? '',
      status: json['status'] ?? '',
      synopsis: json['synopsis'] ?? '',
      chapter: chapterList,
    );
  }

  @override
  List<Object?> get props => [title, thumb, author, status, synopsis, chapter];
}

class ChapterInfo extends Equatable {
  final String chapterTitle;
  final String chapterEndpoint;

  const ChapterInfo({
    required this.chapterTitle,
    required this.chapterEndpoint,
  });

  factory ChapterInfo.fromJson(Map<String, dynamic> json) {
    return ChapterInfo(
      chapterTitle: json['chapter_title'] ?? '',
      chapterEndpoint: json['chapter_endpoint'] ?? '',
    );
  }

  @override
  List<Object?> get props => [chapterTitle, chapterEndpoint];
}
