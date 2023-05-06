class PazirandeModel {
  late String name;
  late String name2;
  late String senf;
  late String mobile;
  late String status;
  late String soeich;
  late String sanad;
  late String noe;
  late String noe2;
  late String emza;
  late String usercode;
  late String tarikh;

  PazirandeModel.fromJson(Map < String , dynamic> parsedJson) {
    name = parsedJson['namepazirande'];
    name2 = parsedJson['nameforoshgah'];
    senf = parsedJson['senf'];
    mobile = parsedJson['mobile'];
    status = parsedJson['vaziyat'];
    soeich = parsedJson['soeich'];
    sanad = parsedJson['sanad'];
    noe = parsedJson['noe'];
    noe2 = parsedJson['noe2'];
    emza = parsedJson['emza'];
    usercode = parsedJson['usercode'];
    tarikh = parsedJson['tarikh'];
  }

}