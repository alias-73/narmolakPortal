class SanadModel {
  late String sanad;

  SanadModel.fromJson(Map < String , dynamic> parsedJson) {
    sanad = parsedJson['sanad'];
  }

}