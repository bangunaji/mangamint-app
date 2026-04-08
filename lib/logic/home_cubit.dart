import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../data/models/manga_model.dart';
import '../data/sources/api_client.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<Manga> popularManga;
  final List<Manga> latestManga;

  const HomeLoaded({required this.popularManga, required this.latestManga});

  @override
  List<Object?> get props => [popularManga, latestManga];
}

class HomeError extends HomeState {
  final String message;

  const HomeError(this.message);

  @override
  List<Object?> get props => [message];
}

class HomeCubit extends Cubit<HomeState> {
  final ApiClient apiClient;

  HomeCubit(this.apiClient) : super(HomeInitial());

  Future<void> fetchHomeData() async {
    try {
      emit(HomeLoading());
      final popular = await apiClient.getPopularManga();
      final latest = await apiClient.getLatestManga();
      emit(HomeLoaded(popularManga: popular, latestManga: latest));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }
}
