// download_web.dart
import 'dart:html' as html;
import 'package:flutter/material.dart';

Future<void> saveFileToDownloads(
  BuildContext? context,
  String filename,
  String content,
) async {
  final blob = html.Blob([content]);
  final url = html.Url.createObjectUrlFromBlob(blob);
  final anchor = html.AnchorElement(href: url)
    ..setAttribute("download", filename)
    ..click();
  html.Url.revokeObjectUrl(url);

  if (context != null) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Downloaded $filename')));
  }
}
