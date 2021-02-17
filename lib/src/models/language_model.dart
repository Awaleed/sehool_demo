class LanguageModel {
  String code;
  String englishName;
  String localName;
  String flag;
  bool selected;

  LanguageModel(
    this.code,
    this.englishName,
    this.localName,
    this.flag, {
    this.selected = false,
  });

  static List<LanguageModel> get languages => [
        LanguageModel(
          'en',
          'English',
          'English',
          'assets/images/usa.svg',
        ),
        LanguageModel(
          'ar',
          'Arabic',
          'العربية',
          'assets/images/ksa.svg',
        ),
      ];
}
