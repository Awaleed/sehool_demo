class LanguageModel {
  String code;
  String englishName;
  String localName;
  bool selected;

  LanguageModel(
    this.code,
    this.englishName,
    this.localName, {
    this.selected = false,
  });

  static List<LanguageModel> get languages => [
        LanguageModel(
          'en',
          'English',
          'English',
        ),
        LanguageModel(
          'ar',
          'Arabic',
          'العربية',
        ),
      ];
}
