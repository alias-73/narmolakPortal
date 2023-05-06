class SoeichModel {
  late String soeich_no;

  SoeichModel.fromJson(Map< String , dynamic> parsedJson) {
    soeich_no = parsedJson['soeich'];
  }

}