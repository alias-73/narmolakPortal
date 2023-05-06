class NotifyModel {
  late String title;
  late String body;

  NotifyModel.fromJson(Map < String , dynamic> parsedJson) {
    title = parsedJson['onvan'];
    body = parsedJson['sharh'];
  }

}