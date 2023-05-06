class IranKishModel {
  late String shenase;
  late String serial;
  late String terminal;
  late String foroshgah;
  late String pazirande;
  late String mobile;
  late String address;
  late String darkhast;

  IranKishModel.fromJson(Map < String , dynamic> parsedJson) {
    shenase = parsedJson['peygiri'];
    serial = parsedJson['serial'];
    terminal = parsedJson['terminal'];
    foroshgah = parsedJson['foroshgah'];
    pazirande = parsedJson['pazirande'];
    mobile = parsedJson['mobile'];
    address = parsedJson['address'];
    darkhast = parsedJson['sharh'];
  }

}