class NotificationModel {
  late String desc;

  NotificationModel.fromJson(Map < String , dynamic> parsedJson) {
    desc = parsedJson['sharh'];
  }

}