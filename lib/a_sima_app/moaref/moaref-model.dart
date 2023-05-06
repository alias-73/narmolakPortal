class MoarefModel {
 late  String name;
 late  String tell;
 late  String mobile;
 late  String address;
 late  String namepazirande;
 late  String sanadpazirande;

  MoarefModel.fromJson(Map<String , dynamic> parsedJson) {
    name = parsedJson['name'];
    tell = parsedJson['tell'];
    mobile = parsedJson['mobile'];
    address = parsedJson['address'];
    namepazirande = parsedJson['namepazirande'];
    sanadpazirande = parsedJson['sanadpazirande'];
  }

}