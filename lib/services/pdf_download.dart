import 'dart:io';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

Future<void> downloadTranslatedTextAsPdf(String text, BuildContext context) async {
  // Request storage permission
  if (!await Permission.storage.request().isGranted) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Storage permission denied')),
    );
    return;
  }

  final PdfDocument document = PdfDocument();
  final PdfPage page = document.pages.add();
  page.graphics.drawString(
    text.isEmpty ? 'No translated text.' : text,
    PdfStandardFont(PdfFontFamily.helvetica, 14),
  );

  List<int> bytes = await document.save();
  document.dispose();

  // Save in Downloads folder
  final directory = Directory('/storage/emulated/0/Download');
  final path = '${directory.path}/translated_text.pdf';

  final file = File(path);
  await file.writeAsBytes(bytes, flush: true);

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text('PDF saved in Download folder:\n$path')),
  );
}
