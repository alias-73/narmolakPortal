class RizModel {
 late  String cart;
 late  String peygiri;
 late  String saat;
 late  String noe;
 late  String mablaq;
 late  String vaziyat;

  RizModel.fromJson(Map< String , dynamic> parsedJson) {
    cart = parsedJson['cart'];
    peygiri = parsedJson['peygiri'];
    saat = parsedJson['saat'];
    noe = parsedJson['noe'];
    mablaq = parsedJson['mablaq'];
    vaziyat = parsedJson['vaziyat'];
  }

}