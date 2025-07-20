import 'package:flutter/material.dart';
import 'package:language_translator/pages/scan_text.dart';
import 'package:language_translator/provider/translation_provider.dart';
import 'package:language_translator/widgets/language_selection.dart';
import 'package:language_translator/widgets/translate_botton.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          'Language Translator',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.04,
            vertical: screenHeight * 0.02,
          ),
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: isPortrait ? screenHeight * 0.8 : screenHeight * 0.9,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 10,),
                  // Language Selection Row
                  const LanguageSelection(),
                  SizedBox(height: screenHeight * 0.1),

                  // Input Text Field
                  Consumer<TranslationProvider>(
                    builder: (context, provider, child) {
                      return Container(
                        height: isPortrait
                            ? screenHeight * 0.25
                            : screenHeight * 0.4,
                        decoration: BoxDecoration(
                          color: Colors.grey[800],
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey),
                        ),
                        padding: const EdgeInsets.all(12),
                        child: Stack(
                          children: [
                            SingleChildScrollView(
                              child: TextField(
                                controller: provider.inputController,
                                maxLines: null,
                                keyboardType: TextInputType.multiline,
                                decoration: const InputDecoration(
                                  hintText: 'Enter text to translate...',
                                  hintStyle: TextStyle(color: Colors.grey),
                                  border: InputBorder.none,
                                ),
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    onPressed: () async {
                                      final scannedText = await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => ScannerScreen(),
                                        ),
                                      );

                                      if (scannedText != null &&
                                          scannedText is String) {
                                        provider.inputController.text =
                                            scannedText;
                                      }
                                    },
                                    icon: Icon(
                                      Icons.camera,
                                      color: Colors.white,
                                      size: screenWidth * 0.06,
                                    ),
                                  ),
                                  SizedBox(width: screenWidth * 0.02),
                                  TranslateButton(),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),

                  SizedBox(height: screenHeight * 0.03),

                  // Translated Text Label
                  const Text(
                    'Translated Text:',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),

                  // Translated Text Output
                  Consumer<TranslationProvider>(
                    builder: (context, provider, child) {
                      return Container(
                        height: isPortrait
                            ? screenHeight * 0.25
                            : screenHeight * 0.3,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.grey[800],
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: SingleChildScrollView(
                          child: Text(
                            provider.translatedText,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      );
                    },
                  ),

                  // Add some extra space at the bottom for better scrolling
                  SizedBox(height: screenHeight * 0.05),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
