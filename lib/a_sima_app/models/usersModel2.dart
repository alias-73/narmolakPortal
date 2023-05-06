class UserModel2 {
  late String all;
  late String eslah;
  late String takhsis;
  late String faal;
  late String name;
  late String usercode;
  late String imgURL;
  late String target;

  UserModel2.fromJson(Map< String , dynamic> parsedJson) {
    all = parsedJson['all'].toString();
    eslah = parsedJson['eslah'].toString();
    takhsis = parsedJson['takhsis'].toString();
    faal = parsedJson['faal'].toString();
    name = parsedJson['name'].toString();
    usercode = parsedJson['usercode'].toString();
    imgURL = parsedJson['url'].toString();
    target = parsedJson['target'].toString();
  }

}