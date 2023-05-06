class BrandModel {
  late String brandName;

  BrandModel.fromJson(Map < String , dynamic> parsedJson) {
    brandName = parsedJson['name'];
  }

}