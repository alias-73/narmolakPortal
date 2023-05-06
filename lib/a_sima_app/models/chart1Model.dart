class Chart1Model {
  late String date;
  late String count;

  Chart1Model.fromJson(Map < String , dynamic> parsedJson) {
    date = parsedJson['tarikh'];
    count = parsedJson['tedad'].toString();
  }

}