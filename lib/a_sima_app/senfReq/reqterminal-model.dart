class ReqTerminalModel {
  late String shomare;
  late String sanad;
  late String name;
  late String tarikh;
  late String vaziat;
  late String tozihat;

  ReqTerminalModel.fromJson(Map < String , dynamic> parsedJson) {
    shomare = parsedJson['shomare'];
    sanad= parsedJson['sanad'];
    name= parsedJson['name'];
    tarikh = parsedJson['tarikh'];
    vaziat = parsedJson['vaziyat'];
    tozihat= parsedJson['tozihat'];
  }

}