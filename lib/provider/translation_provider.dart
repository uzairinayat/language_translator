import 'dart:typed_data';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:language_translator/models/language.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:translator/translator.dart';

class TranslationProvider with ChangeNotifier {
  final translator = GoogleTranslator();
  final TextEditingController inputController = TextEditingController();

  String _translatedText = '';
  String _pdfExtractedText = '';
  Language _sourceLanguage = languagesList.first;
  Language _targetLanguage = languagesList[1];

  String get translatedText => _translatedText;
  String get pdfExtractedText => _pdfExtractedText;
  Language get sourceLanguage => _sourceLanguage;
  Language get targetLanguage => _targetLanguage;
  TextEditingController get textController => inputController;


  void setSourceLanguage(Language language) {
    _sourceLanguage = language;
    notifyListeners();
  }

  void setTargetLanguage(Language language) {
    _targetLanguage = language;
    notifyListeners();
  }

  /// Unified Translate Function (Text or PDF Text)
  Future<void> translateText(BuildContext context) async {
    String textToTranslate = '';

    // Determine which source to translate:
    if (inputController.text.trim().isNotEmpty) {
      textToTranslate = inputController.text.trim();
    } else if (_pdfExtractedText.trim().isNotEmpty) {
      textToTranslate = _pdfExtractedText.trim();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter text or extract text from PDF.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    try {
      var translation = await translator.translate(
        textToTranslate,
        from: _sourceLanguage.code,
        to: _targetLanguage.code,
      );

      _translatedText = translation.text;
      notifyListeners();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Translation error: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  /// PDF Text Extraction
  Future<void> extractTextFromPDF(BuildContext context) async {
    try {
      // Pick PDF File
      final XFile? file = await openFile(
        acceptedTypeGroups: [
          XTypeGroup(label: 'PDF Files', extensions: ['pdf']),
        ],
      );

      if (file != null) {
        // Read bytes from the picked PDF file
        Uint8List bytes = await file.readAsBytes();

        // Extract PDF text using Syncfusion PDF package
        PdfDocument document = PdfDocument(inputBytes: bytes);
        _pdfExtractedText = PdfTextExtractor(document).extractText();
        document.dispose();

        notifyListeners();
      } else {
        _pdfExtractedText = 'No PDF selected.';
        notifyListeners();
      }
    } catch (e) {
      _pdfExtractedText = 'PDF extraction error: $e';
      notifyListeners();
    }
  }
}

