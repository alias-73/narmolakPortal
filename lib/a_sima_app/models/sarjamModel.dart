class SarjamModel {
  late String tarakoneshhas;
  late String tedadkol;
  late String mablaqkol;
  late String mandetedad;
  late String qabztedad;
  late String qabzsum;
  late String kharidtedad;
  late String kharidsum;
  late String sharjtedad;
  late String sal;
  late String sharjsum;
  late String mah;

  SarjamModel.fromJson(Map < String , dynamic> parsedJson) {
    tarakoneshhas = parsedJson['tarakoneshhas'];
    tedadkol = parsedJson['tedadkol'];
    mablaqkol = parsedJson['mablaqkol'];
    mandetedad = parsedJson['mandetedad'];
    qabztedad = parsedJson['qabztedad'];
    qabzsum = parsedJson['qabzsum'];
    kharidtedad = parsedJson['kharidtedad'];
    kharidsum = parsedJson['kharidsum'];
    sharjtedad = parsedJson['sharjtedad'];
    sal = parsedJson['sal'];
    mah = parsedJson['mah'];
    sharjsum = parsedJson['sharjsum'];
  }

}