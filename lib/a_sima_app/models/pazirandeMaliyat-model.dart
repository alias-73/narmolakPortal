class PazirandeMaliyatModel {
  late String name;
  late String sanad;
  late String foroshgah;
  late String mobile;
  late String tel;
  late String address;
  late String mohlat;
  late String terminal;
  late String sharh;

  PazirandeMaliyatModel.fromJson(Map < String , dynamic> parsedJson) {
    name = parsedJson['namep'];
    foroshgah = parsedJson['namef'];
    mobile = parsedJson['mobile'];
    tel = parsedJson['tell'];
    address = parsedJson['address'];
    mohlat = parsedJson['mohlat'];
    sanad = parsedJson['sanad'];
    terminal = parsedJson['terminal'];
    sharh = parsedJson['sharh'];
  }

}