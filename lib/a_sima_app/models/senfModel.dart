class SenfModel {
   late String senfName;

  SenfModel.fromJson(Map < String , dynamic> parsedJson) {
    senfName = parsedJson['name'];
  }

}