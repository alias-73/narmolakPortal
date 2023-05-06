class AlarmModel {
  late String alarm;

  AlarmModel.fromJson(Map < String , dynamic> parsedJson) {
    alarm = parsedJson['vaziyat'];

  }

}