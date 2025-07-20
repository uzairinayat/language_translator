import 'package:flutter/material.dart';
import 'package:language_translator/models/language.dart';

class LanguageDropdown extends StatelessWidget {
  final Language selectedLanguage;
  final List<Language> languages;
  final String label;
  final double? fontSize;  // Made nullable to calculate dynamically
  final Color selectedTextColor;
  final Color menuTextColor;
  final Color iconColor;
  final Color dropdownColor;
  final ValueChanged<Language> onChanged;

  const LanguageDropdown({
    required this.selectedLanguage,
    required this.languages,
    required this.label,
    this.fontSize,  // Now optional
    required this.selectedTextColor,
    required this.menuTextColor,
    required this.iconColor,
    required this.dropdownColor,
    required this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isPortrait = mediaQuery.orientation == Orientation.portrait;
    
    // Calculate dynamic sizes based on screen dimensions
    final double calculatedFontSize = fontSize ?? 
        (isPortrait 
            ? mediaQuery.size.width * 0.04 
            : mediaQuery.size.height * 0.025);
    
    final double dropdownHeight = isPortrait 
        ? mediaQuery.size.height * 0.065 
        : mediaQuery.size.height * 0.09;

    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          height: dropdownHeight,
          constraints: BoxConstraints(
            minWidth: constraints.maxWidth * 0.4,  // Minimum 40% of available width
          ),
          child: DropdownButtonFormField<Language>(
            value: selectedLanguage,
            isExpanded: true,  // Important for responsiveness
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                horizontal: mediaQuery.size.width * 0.03,
                vertical: isPortrait 
                    ? mediaQuery.size.height * 0.01 
                    : mediaQuery.size.height * 0.005,
              ),
              labelText: label,
              labelStyle: TextStyle(
                color: Colors.white,
                fontSize: calculatedFontSize * 0.9,  // Slightly smaller than item text
              ),
              filled: true,
              fillColor: Colors.grey[850],
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey[700]!),
                borderRadius: BorderRadius.circular(8),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            dropdownColor: dropdownColor,
            iconEnabledColor: iconColor,
            icon: Icon(
              Icons.arrow_drop_down,
              size: calculatedFontSize * 1.5,
            ),
            style: TextStyle(
              color: selectedTextColor,
              fontSize: calculatedFontSize,
            ),
            items: languages.map((lang) {
              return DropdownMenuItem<Language>(
                value: lang,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: isPortrait 
                        ? mediaQuery.size.height * 0.005 
                        : 0,
                  ),
                  child: Text(
                    lang.name,
                    style: TextStyle(
                      color: menuTextColor,
                      fontSize: calculatedFontSize,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              );
            }).toList(),
            onChanged: (value) {
              if (value != null) {
                onChanged(value);
              }
            },
          ),
        );
      },
    );
  }
}