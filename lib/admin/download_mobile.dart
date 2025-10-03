import 'dart:io';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;

Future<void> saveFileToDownloads(
  BuildContext context,
  String filename,
  String content,
) async {
  try {
    // Request permission
    bool granted = await _requestStoragePermission();
    if (!granted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Storage permission denied")),
      );
      return;
    }

    // Get Downloads folder path
    Directory? downloadsDir = Directory('/storage/emulated/0/Download');
    if (!downloadsDir.existsSync()) {
      downloadsDir.createSync(recursive: true);
    }

    final file = File(path.join(downloadsDir.path, filename));
    await file.writeAsString(content);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Template saved to Downloads/$filename")),
    );
  } catch (e) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("Failed to save file: $e")));
  }
}

Future<bool> _requestStoragePermission() async {
  if (Platform.isAndroid) {
    PermissionStatus status = await Permission.manageExternalStorage.status;
    if (status.isGranted) return true;

    status = await Permission.manageExternalStorage.request();
    return status.isGranted;
  }
  return true;
}
