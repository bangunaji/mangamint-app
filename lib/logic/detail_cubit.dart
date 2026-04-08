import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../data/models/detail_model.dart';
import '../data/sources/api_client.dart';

abstract class DetailState extends Equatable {
  const DetailState();

  @override
  List<Object?> get props => [];
}

class DetailInitial extends DetailState {}

class DetailLoading extends DetailState {}

class DetailLoaded extends DetailState {
  final DetailManga detail;

  const DetailLoaded(this.detail);

  @override
  List<Object?> get props => [detail];
}

class DetailError extends DetailState {
  final String message;

  const DetailError(this.message);

  @override
  List<Object?> get props => [message];
}

class DetailCubit extends Cubit<DetailState> {
  final ApiClient apiClient;

  DetailCubit(this.apiClient) : super(DetailInitial());

  Future<void> fetchDetail(String endpoint) async {
    try {
      emit(DetailLoading());
      final detail = await apiClient.getMangaDetail(endpoint);
      emit(DetailLoaded(detail));
    } catch (e) {
      emit(DetailError(e.toString()));
    }
  }
}
