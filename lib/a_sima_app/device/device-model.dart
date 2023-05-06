class DeviceModel {
  late String serial;
  late String brand;
  late String model;
  late String status;
  late String soeich;

  DeviceModel.fromJson(Map < String , dynamic> parsedJson) {
    serial = parsedJson['serial'];
    brand = parsedJson['brand'];
    model = parsedJson['model'];
    status = parsedJson['vaziyat'];
    soeich = parsedJson['soeich'];
  }

}