class MemberCoModel {
  late String name;
  late String meli;
  late String tavalod;
  late String telpish;
  late String tel;
  late String mobilepish;
  late String mobile;
  late String status;
  late String id;

  MemberCoModel.fromJson(Map < String , dynamic> parsedJson) {
    name = parsedJson['name'];
    meli = parsedJson['meli'];
    tavalod = parsedJson['tavalod'];
    telpish = parsedJson['tellpish'];
    tel = parsedJson['tell'];
    mobilepish = parsedJson['mobilepish'];
    mobile = parsedJson['mobile'];
    status = parsedJson['status'];
    id = parsedJson['id'];
  }

}