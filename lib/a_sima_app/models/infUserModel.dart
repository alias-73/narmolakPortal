class UserInfModel {
  late String name;
  late String tell;
  late String mobile;
  late String ostan;

  UserInfModel.fromJson(Map < String , dynamic> parsedJson) {
    name = parsedJson['name'];
    tell = parsedJson['tell'];
    mobile = parsedJson['mobile'];
    ostan = parsedJson['ostan'];
  }

}