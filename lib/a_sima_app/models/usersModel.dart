class UserModel {
  late String code;
  late String name;
  late String tell;
  late String mobile;

  UserModel.fromJson(Map< String , dynamic> parsedJson) {
    code = parsedJson['code'];
    name = parsedJson['name'];
    tell = parsedJson['tell'];
    mobile = parsedJson['mobile'];
  }

}