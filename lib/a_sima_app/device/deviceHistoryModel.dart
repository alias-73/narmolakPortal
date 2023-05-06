class DeviceHistoryModel {
  late String title;
  late String desc;
  late String date;
  late String user;

  DeviceHistoryModel.fromJson(Map < String , dynamic> parsedJson) {
    title = parsedJson['onvan'];
    desc = parsedJson['sharh'];
    date = parsedJson['tarikh'];
    user = parsedJson['user'];
  }

}