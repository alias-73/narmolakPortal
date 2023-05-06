class ImgAddressModel {
  late String img;
  late String url;

  ImgAddressModel.fromJson(Map < String , dynamic> parsedJson) {
    img = parsedJson['img'];
    url = parsedJson['url'];
  }

}