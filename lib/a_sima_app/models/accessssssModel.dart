class AccessModel1 {
  late String section;
  late String vaziat;


  AccessModel1.fromJson(Map < String , dynamic> parsedJson) {
    section = parsedJson['section'];
    vaziat = parsedJson['vaziyat'] ;

  }

}