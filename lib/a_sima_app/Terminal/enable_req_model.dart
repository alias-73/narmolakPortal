class EnableReqModel {
  late String tarikh;
  late String saat;
  late String tozih;
  late String vaziat;

  EnableReqModel.fromJson(Map< String , dynamic> parsedJson) {
    tarikh = parsedJson['tarikh'];
    saat = parsedJson['saat'];
    tozih = parsedJson['tozih'];
    vaziat = parsedJson['vaziyat'];
  }

}