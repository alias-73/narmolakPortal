class RizWalletModel {
   late String tarikh;
   late String saat;
   //late String sanad;
   late String noe;
   late String sharh;
   late String bed;
   late String bes;

  RizWalletModel.fromJson(Map < String , dynamic> parsedJson) {
    tarikh = parsedJson['tarikh'];
    saat = parsedJson['saat'];
  //  sanad = parsedJson['sanad'];
    noe = parsedJson['noe'];
    sharh = parsedJson['sharh'];
    bed = parsedJson['bed'];
    bes = parsedJson['bes'];
  }
}