import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storage_app/services/storage/storage_services.dart';

class ImagePost extends StatelessWidget {
  const ImagePost({super.key, required this.imageUrl});

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Consumer<StorageServices>(
      builder: (context, storageServices, child) {
        if (storageServices.isUploading) {
          return const SizedBox(
            height: 257,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        return Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              IconButton.outlined(
                  onPressed: () =>
                      storageServices.deleteImage(imageUrl: imageUrl),
                  icon: const Icon(Icons.delete)),
              Image.network(
                imageUrl,
                fit: BoxFit.fitWidth,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress != null) {
                    // loading circle...
                    return SizedBox(
                      height: 257,
                      child: Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      ),
                    );
                  } else {
                    return child;
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
