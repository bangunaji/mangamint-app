import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../data/models/manga_model.dart';
import '../data/sources/api_client.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object?> get props => [];
}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchLoaded extends SearchState {
  final List<Manga> results;

  const SearchLoaded(this.results);

  @override
  List<Object?> get props => [results];
}

class SearchError extends SearchState {
  final String message;

  const SearchError(this.message);

  @override
  List<Object?> get props => [message];
}

class SearchCubit extends Cubit<SearchState> {
  final ApiClient apiClient;

  SearchCubit(this.apiClient) : super(SearchInitial());

  Future<void> searchManga(String query) async {
    if (query.isEmpty) {
      emit(SearchInitial());
      return;
    }
    
    try {
      emit(SearchLoading());
      final results = await apiClient.searchManga(query);
      emit(SearchLoaded(results));
    } catch (e) {
      emit(SearchError(e.toString()));
    }
  }
}
