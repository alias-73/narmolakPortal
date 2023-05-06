class PazirandeHistoryModel {
  late String time;
  late String date;
  late String name;
  late String disc;

  PazirandeHistoryModel.fromJson(Map < String , dynamic> parsedJson) {
    name = parsedJson['user'];
    time = parsedJson['saat'];
    date = parsedJson['tarikh'];
    disc = parsedJson['sharh'];
  }

}