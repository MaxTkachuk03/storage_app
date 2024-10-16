import 'package:flutter/material.dart';
import 'package:storage_app/pages/pages.dart';

class StorageApp extends StatelessWidget {
  const StorageApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
