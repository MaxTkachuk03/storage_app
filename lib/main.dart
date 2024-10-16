import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storage_app/firebase_options.dart';
import 'package:storage_app/services/storage/storage_services.dart';
import 'package:storage_app/storage_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(ChangeNotifierProvider(
    create: (context) => StorageServices(),
    child: const StorageApp(),
  ));
}
