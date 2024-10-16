import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class StorageServices with ChangeNotifier {
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  List<String> _imageUrls = [];

  bool _isLoading = false;

  bool _isUploading = false;

  List<String> get imageUrls => _imageUrls;
  bool get isLoading => _isLoading;
  bool get isUploading => _isUploading;

  Future<void> fetchImages() async {
    _isLoading = true;

    final ListResult result =
        await firebaseStorage.ref('uploaded_images/').listAll();

    _imageUrls =
        await Future.wait(result.items.map((ref) => ref.getDownloadURL()));

    _isLoading = false;

    notifyListeners();
  }

  Future<void> deleteImage({required String imageUrl}) async {
    try {
      _imageUrls.remove(imageUrl);

      final String path = extractPathFromUrl(url: imageUrl);

      await firebaseStorage.ref(path).delete();
    } catch (e) {
      print("OOOOps...");
    }
    notifyListeners();
  }

  String extractPathFromUrl({required String url}) {
    Uri uri = Uri.parse(url);

    String encodedPath = uri.pathSegments.last;

    return Uri.decodeComponent(encodedPath);
  }

  Future<void> uploadImage() async {
    // start uploading...
    _isUploading = true;
    // update UI
    notifyListeners();

    // pick an image
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image == null) return; // user cancelled the picker

    File file = File(image.path);

    try {
      // define the path in storage
      String filePath = 'uploaded_images/${DateTime.now()}.png';

      // upload the file to firebase storage
      await firebaseStorage.ref(filePath).putFile(file);

      // fetch the download url
      String downloadUrl = await firebaseStorage.ref(filePath).getDownloadURL();

      // update the image urls list UI
      _imageUrls.add(downloadUrl);
      notifyListeners();
    } catch (e) {
      print('Error uploading: $e');
    } finally {
      _isUploading = false;
      notifyListeners();
    }
  }
}
