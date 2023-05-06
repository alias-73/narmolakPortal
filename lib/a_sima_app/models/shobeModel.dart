class ShobeModel {
  late String shobeName;

  ShobeModel.fromJson(Map< String , dynamic> parsedJson) {
    shobeName = parsedJson['shobe'];
  }

}