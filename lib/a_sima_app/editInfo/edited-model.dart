class EditedModel {
  late String codemeli;
  late String serial;
  late String harf;
  late String seri;
  late String mobile;
  late String mobilepish;
  late String maliyat;
  late String vaziyat;

  EditedModel.fromJson(Map< String , dynamic> parsedJson) {
    codemeli = parsedJson['codemeli'];
    serial = parsedJson['serial'];
    harf = parsedJson['harf'];
    seri = parsedJson['seri'];
    mobile= parsedJson['mobile'];
    mobilepish= parsedJson['mobilepish'];
    maliyat= parsedJson['maliyat'];
    vaziyat= parsedJson['vaziyat'];
  }

}