class PazirandeModel2 {
  late String pazirande;

  PazirandeModel2.fromJson(Map < String , dynamic> parsedJson) {
    pazirande = parsedJson['pazirande'];
  }

}