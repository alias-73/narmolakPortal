class CheckSerialModel {
  late String sanad;
  late String name;
  late String terminal;
  late String forushgah;
  late String soeich;
  late String model;

  CheckSerialModel.fromJson(Map < String , dynamic> parsedJson) {
    sanad = parsedJson['sanad'];
    name = parsedJson['name'];
    terminal = parsedJson['terminal'];
    forushgah = parsedJson['foroshgah'];
    soeich = parsedJson['soeich'];
    model = parsedJson['model'];
  }

}