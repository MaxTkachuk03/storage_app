import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storage_app/components/components.dart';
import 'package:storage_app/services/storage/storage_services.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    fetchImages();
    super.initState();
  }

  Future<void> fetchImages() async {
    await context.read<StorageServices>().fetchImages();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<StorageServices>(
        builder: (context, storageServices, child) {
      final List<String> imagesUrls = storageServices.imageUrls;
      return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () => storageServices.uploadImage(),
          child: const Icon(Icons.add_a_photo),
        ),
        body: ListView.builder(
            padding:
                const EdgeInsets.symmetric(horizontal: 25.0, vertical: 60.0),
            itemCount: imagesUrls.length,
            itemBuilder: (builder, index) {
              final imageUrl = imagesUrls[index];

              return ImagePost(imageUrl: imageUrl);
            }),
      );
    });
  }
}
