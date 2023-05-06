class OstanModel {
  late String ostanName;

  OstanModel.fromJson(Map < String , dynamic> parsedJson) {
    ostanName = parsedJson['name'];
  }

}