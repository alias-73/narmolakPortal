class InfoTakhsisModel1 {
late String noe;
late String psp;
late String ostan;
late String shahr;

  InfoTakhsisModel1.fromJson(Map<String , dynamic> parsedJson) {
    noe = parsedJson['model'];
    psp = parsedJson['panel'];
    ostan = parsedJson['ostan'];
    shahr = parsedJson['shahr'];
  }

}