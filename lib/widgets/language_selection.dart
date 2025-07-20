import 'package:flutter/material.dart';
import 'package:language_translator/models/language.dart';
import 'package:language_translator/provider/translation_provider.dart';
import 'package:language_translator/utils/language_dropdown.dart';
import 'package:provider/provider.dart';

class LanguageSelection extends StatelessWidget {
  const LanguageSelection({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TranslationProvider>(
      builder: (context, provider, child) {
        return Row(
          children: [
            Expanded(
              child: Container(
                height: 42,
                padding: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  color: Colors.grey[900],  // modern dark background
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.blueGrey),
                ),
                child: LanguageDropdown(
                  selectedLanguage: provider.sourceLanguage,
                  languages: languagesList,
                  label: '',
                  fontSize: 12,
                  selectedTextColor: Colors.white,
                  menuTextColor: Colors.white,
                  iconColor: Colors.white,
                  dropdownColor: Colors.grey[850]!,
                  onChanged: provider.setSourceLanguage,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Container(
                height: 42,
                padding: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  color: Colors.grey[900],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.blueGrey),
                ),
                child: LanguageDropdown(
                  selectedLanguage: provider.targetLanguage,
                  languages: languagesList,
                  label: '',
                  fontSize: 12,
                  selectedTextColor: Colors.white,
                  menuTextColor: Colors.white,
                  iconColor: Colors.white,
                  dropdownColor: Colors.grey[850]!,
                  onChanged: provider.setTargetLanguage,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
