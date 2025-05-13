import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

class FullImageViewer extends StatelessWidget {
  final String imagePath;

  const FullImageViewer({super.key, required this.imagePath});

  Future<void> _downloadImage(BuildContext context) async {
    try {
      final byteData = await rootBundle.load(imagePath);
      final buffer = byteData.buffer;

      final directory = await getApplicationDocumentsDirectory();
      final fileName = imagePath.split('/').last;
      final filePath = '${directory.path}/$fileName';

      final file = File(filePath);
      await file.writeAsBytes(
        buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes),
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Saved to $filePath')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to save image')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.download),
            onPressed: () => _downloadImage(context),
            tooltip: 'Download',
          ),
        ],
      ),
      body: Center(
        child: InteractiveViewer(
          child: Image.asset(imagePath),
        ),
      ),
    );
  }
}