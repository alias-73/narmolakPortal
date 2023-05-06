class RizModel2 {
 late  String cart;
 late  String peygiri;
 late  String saat;
 late  String noe;
 late  String mablaq;
 late  String vaziyat;

  RizModel2.fromJson(Map< String , dynamic> parsedJson) {
    cart = parsedJson['cart'];
    peygiri = parsedJson['peygiri'];
    saat = parsedJson['saat'];
    noe = parsedJson['noe'];
    mablaq = parsedJson['mablaq'];
    vaziyat = parsedJson['vaziyat'];
  }

}