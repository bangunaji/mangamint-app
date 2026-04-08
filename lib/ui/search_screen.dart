import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../logic/search_cubit.dart';
import 'detail_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          autofocus: true,
          decoration: const InputDecoration(
            hintText: 'Search manga...',
            border: InputBorder.none,
          ),
          onSubmitted: (value) {
            context.read<SearchCubit>().searchManga(value);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              context.read<SearchCubit>().searchManga(_searchController.text);
            },
          )
        ],
      ),
      body: BlocBuilder<SearchCubit, SearchState>(
        builder: (context, state) {
          if (state is SearchLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is SearchError) {
            return Center(child: Text(state.message));
          } else if (state is SearchLoaded) {
            if (state.results.isEmpty) {
              return const Center(child: Text('No results found.'));
            }
            return ListView.builder(
              itemCount: state.results.length,
              itemBuilder: (context, index) {
                final manga = state.results[index];
                return ListTile(
                  leading: CachedNetworkImage(
                    imageUrl: manga.thumb,
                    width: 50,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => const CircularProgressIndicator(),
                    errorWidget: (context, url, error) => const Icon(Icons.error),
                  ),
                  title: Text(manga.title),
                  subtitle: Text(manga.type),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DetailScreen(endpoint: manga.endpoint)),
                    );
                  },
                );
              },
            );
          }
          return const Center(child: Text('Type to search for manga'));
        },
      ),
    );
  }
}
