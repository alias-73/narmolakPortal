class CheckIMEIModel {
  late String sanad;
  late String name;
  late String mobilepish;
  late String mobile;
  late String soeich;
  late String serial;
  late String brand;
  late String model;
  late String url;

  CheckIMEIModel.fromJson(Map < String , dynamic> parsedJson) {
    sanad = parsedJson['sanad'];
    name = parsedJson['name'];
    mobilepish = parsedJson['mobilepish'];
    mobile = parsedJson['mobile'];
    soeich = parsedJson['soeich'];
    serial = parsedJson['serial'];
    brand = parsedJson['bran'];
    model = parsedJson['model'];
    url = parsedJson['url'];
  }

}