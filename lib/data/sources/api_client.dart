import 'package:dio/dio.dart';
import '../models/manga_model.dart';
import '../models/detail_model.dart';
import '../models/chapter_model.dart';

class ApiClient {
  final Dio _dio;

  ApiClient() : _dio = Dio(BaseOptions(baseUrl: 'https://mangamint.kaedenoki.net/api/'));

  Future<List<Manga>> getPopularManga({int page = 1}) async {
    try {
      final response = await _dio.get('manga/popular/$page');
      final List data = response.data['manga_list'] ?? [];
      return data.map((json) => Manga.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to load popular manga');
    }
  }

  Future<List<Manga>> getLatestManga({int page = 1}) async {
    try {
      final response = await _dio.get('manga/page/$page');
      final List data = response.data['manga_list'] ?? [];
      return data.map((json) => Manga.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to load latest manga');
    }
  }

  Future<List<Manga>> searchManga(String query) async {
    try {
      final response = await _dio.get('search/$query');
      final List data = response.data['manga_list'] ?? [];
      return data.map((json) => Manga.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to search manga');
    }
  }

  Future<DetailManga> getMangaDetail(String endpoint) async {
    try {
      final response = await _dio.get('manga/detail/$endpoint');
      return DetailManga.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to load manga detail');
    }
  }

  Future<ChapterImages> getChapterImages(String endpoint) async {
    try {
      final response = await _dio.get('chapter/$endpoint');
      return ChapterImages.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to load chapter images: $e');
    }
  }
}
