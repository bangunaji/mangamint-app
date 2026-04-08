import 'package:equatable/equatable.dart';

class Manga extends Equatable {
  final String title;
  final String thumb;
  final String endpoint;
  final String type;

  const Manga({
    required this.title,
    required this.thumb,
    required this.endpoint,
    required this.type,
  });

  factory Manga.fromJson(Map<String, dynamic> json) {
    return Manga(
      title: json['title'] ?? '',
      thumb: json['thumb'] ?? '',
      endpoint: json['endpoint'] ?? '',
      type: json['type'] ?? '',
    );
  }

  @override
  List<Object?> get props => [title, thumb, endpoint, type];
}
