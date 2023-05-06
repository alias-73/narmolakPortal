class InfoTakhsisModel2 {
 late String bank;
 late String sheba;
 late String hesab;

  InfoTakhsisModel2.fromJson(Map<String , dynamic> parsedJson) {
    bank = parsedJson['bank'];
    sheba = parsedJson['shaba'];
    hesab = parsedJson['hesab'];
  }

}