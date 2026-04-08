import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../logic/reader_cubit.dart';

class ReaderScreen extends StatefulWidget {
  final String endpoint;
  final String title;

  const ReaderScreen({Key? key, required this.endpoint, required this.title}) : super(key: key);

  @override
  State<ReaderScreen> createState() => _ReaderScreenState();
}

class _ReaderScreenState extends State<ReaderScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ReaderCubit>().fetchChapterImages(widget.endpoint);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.black,
      ),
      body: BlocBuilder<ReaderCubit, ReaderState>(
        builder: (context, state) {
          if (state is ReaderLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ReaderError) {
            return Center(child: Text(state.message, style: const TextStyle(color: Colors.white)));
          } else if (state is ReaderLoaded) {
            final images = state.chapterImages.images;
            return ListView.builder(
              itemCount: images.length,
              itemBuilder: (context, index) {
                return CachedNetworkImage(
                  imageUrl: images[index],
                  fit: BoxFit.fitWidth,
                  placeholder: (context, url) => const SizedBox(
                    height: 300,
                    child: Center(child: CircularProgressIndicator()),
                  ),
                  errorWidget: (context, url, error) => const SizedBox(
                    height: 300,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.error, color: Colors.red, size: 50),
                          SizedBox(height: 8),
                          Text('Failed to load image', style: TextStyle(color: Colors.white)),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
          return Container();
        },
      ),
    );
  }
}
