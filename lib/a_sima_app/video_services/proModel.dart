class ProductModel {
  late String title;
  late String decs;
  late String img;
  late String url;

  ProductModel.fromJson(Map < String , dynamic> parsedJson) {
    title = parsedJson['onvan'];
    decs = parsedJson['sharh'];
    img = parsedJson['img'];
    url = parsedJson['film'];
  }

}