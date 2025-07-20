class Language {
  final String name;
  final String code;

  Language({required this.name, required this.code});
}

final List<Language> languagesList = [
  Language(name: 'English', code: 'en'),
  Language(name: 'Urdu', code: 'ur'),
  Language(name: 'Spanish', code: 'es'),
  Language(name: 'French', code: 'fr'),
  Language(name: 'German', code: 'de'),
  Language(name: 'Chinese (Simplified)', code: 'zh-cn'),
  Language(name: 'Arabic', code: 'ar'),
];