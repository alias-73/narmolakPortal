class EhrazModel {
  late String q;
  late String a;

  EhrazModel.fromJson(Map < String , dynamic> parsedJson) {
    q = parsedJson['question'];
    a = parsedJson['answer'];
  }

}