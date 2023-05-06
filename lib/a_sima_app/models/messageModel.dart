class MessageModel {
  late String date;
  late String message;

  MessageModel.fromJson(Map < String , dynamic> parsedJson) {
    date = parsedJson['tarikh'];
    message = parsedJson['message'];
  }

}