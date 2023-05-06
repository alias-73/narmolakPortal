class VideoFilterModel {
  late String title;
  late String value;

  VideoFilterModel.fromJson(Map < String , dynamic> parsedJson) {
    title = parsedJson['title'];
    value = parsedJson['value'];
  }

}