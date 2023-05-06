class PersonalMessageModel {
  late String message;

  PersonalMessageModel.fromJson(Map < String , dynamic> parsedJson) {
    message = parsedJson['message'];
  }

}