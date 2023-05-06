class BrandModelModel {
  late String modelName;

  BrandModelModel.fromJson(Map < String , dynamic> parsedJson) {
    modelName = parsedJson['model'];
  }

}