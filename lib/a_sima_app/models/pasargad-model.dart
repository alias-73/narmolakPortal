class PasargadModel {
  late String shenase;
  late String noe;
  late String serial;
  late String version;
  late String terminal;
  late String foroshgah;
  late String pazirande;
  late String mobile;
  late String address;
  late String darkhast;

  PasargadModel.fromJson(Map < String , dynamic> parsedJson) {
    shenase = parsedJson['shenase'];
    noe = parsedJson['noe'];
    serial = parsedJson['serial'];
    version = parsedJson['version'];
    terminal = parsedJson['terminal'];
    foroshgah = parsedJson['foroshgah'];
    pazirande = parsedJson['pazirande'];
    mobile = parsedJson['mobile'];
    address = parsedJson['address'];
    darkhast = parsedJson['darkhast'];
  }

}