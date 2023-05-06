class NesbatMoarefModel {
  late String name;

  NesbatMoarefModel.fromJson(Map < String , dynamic> parsedJson) {

    name = parsedJson['nesbat'];
  }

}