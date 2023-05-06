class IMEIModel {
  late String tarikh;
  late String saat;
  late String terminal;
  late String serial;
  late String imei;
  late String mobile;
  late String apn;
  late String soeich;
  late String vaziyat;

  IMEIModel.fromJson(Map < String , dynamic> parsedJson) {
    tarikh= parsedJson['tarikh'];
    saat= parsedJson['saat'];
    terminal = parsedJson['terminal'];
    serial= parsedJson['serial'];
    imei = parsedJson['imei'];
    mobile= parsedJson['mobile'];
    apn = parsedJson['apn'];
    soeich= parsedJson['soeich'];
    vaziyat= parsedJson['vaziyat'];
  }

}