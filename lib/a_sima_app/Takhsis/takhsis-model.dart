class TakhsisModel {
late  String sanad;
late  String name2;
late  String terminal;
late  String serial;
late  String brand;
late  String model;
late  String status;
late  String foroshgah;

  TakhsisModel.fromJson(Map<String , dynamic> parsedJson) {
    sanad = parsedJson['sanadpazirande'];
    name2 = parsedJson['names'];
    terminal = parsedJson['terminal'];
    serial = parsedJson['serial'];
    brand = parsedJson['brand'];
    model = parsedJson['model'];
    status = parsedJson['vaziyat'];
    foroshgah = parsedJson['foroshgah'];
  }

}