class JaygoziniModel {
  late String sanad;
  late String name;
  late String serialold;
  late String serialnew;
  late String vaziat;

  JaygoziniModel.fromJson(Map< String , dynamic> parsedJson) {
    sanad = parsedJson['sanad'];
    name = parsedJson['name'];
    serialold = parsedJson['serialold'];
    vaziat = parsedJson['vaziyat'];
    serialnew= parsedJson['serialnew'];
  }

}