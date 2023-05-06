class SerialModel {
  late String serial_no;

  SerialModel.fromJson(Map < String , dynamic> parsedJson) {
    serial_no = parsedJson['serial'];
  }

}