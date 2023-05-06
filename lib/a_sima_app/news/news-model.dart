class NewsModel {
  late String no;
  late String title;
  late String desc;
  late String date;

  NewsModel.fromJson(Map< String , dynamic> parsedJson) {
    no = parsedJson['shomare'];
    title= parsedJson['onvan'];
    desc= parsedJson['sharh'];
    date= parsedJson['tarikh'];
  }

}