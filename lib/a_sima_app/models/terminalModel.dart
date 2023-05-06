class TerminalModel {
  late String sanad;
  late String terminal;
  late String name;
  late String foroshgah;
  late String serial;
  late String brand;
  late String model;

  TerminalModel.fromJson(Map< String , dynamic> parsedJson) {
    sanad = parsedJson['sanad'];
    terminal = parsedJson['terminal'];
    name = parsedJson['name'];
    foroshgah = parsedJson['foroshgah'];
    serial = parsedJson['serial'];
    brand = parsedJson['brand'];
    model = parsedJson['model'];
  }

}