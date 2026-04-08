import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../data/models/chapter_model.dart';
import '../data/sources/api_client.dart';

abstract class ReaderState extends Equatable {
  const ReaderState();

  @override
  List<Object?> get props => [];
}

class ReaderInitial extends ReaderState {}

class ReaderLoading extends ReaderState {}

class ReaderLoaded extends ReaderState {
  final ChapterImages chapterImages;

  const ReaderLoaded(this.chapterImages);

  @override
  List<Object?> get props => [chapterImages];
}

class ReaderError extends ReaderState {
  final String message;

  const ReaderError(this.message);

  @override
  List<Object?> get props => [message];
}

class ReaderCubit extends Cubit<ReaderState> {
  final ApiClient apiClient;

  ReaderCubit(this.apiClient) : super(ReaderInitial());

  Future<void> fetchChapterImages(String endpoint) async {
    try {
      emit(ReaderLoading());
      final images = await apiClient.getChapterImages(endpoint);
      emit(ReaderLoaded(images));
    } catch (e) {
      emit(ReaderError(e.toString()));
    }
  }
}
