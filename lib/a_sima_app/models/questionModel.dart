class QuestionModel {
  late String title;
  late String desc;

  QuestionModel.fromJson(Map < String , dynamic> parsedJson) {
    title = parsedJson['onvan'];
    desc = parsedJson['sharh'];
  }

}