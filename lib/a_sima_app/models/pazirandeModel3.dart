class PazirandeModel3 {
  late String namefa;
  late String lastfa;
  late String nameen;
  late String lasten;
  late String pedaren;
  late String pedarfa;
  late String tavalod;
  late String shsh;
  late String gensiat;
  late String meliat;

  PazirandeModel3.fromJson(Map < String , dynamic> parsedJson) {
    namefa = parsedJson['namefa'];
    lastfa = parsedJson['lastfa'];
    nameen = parsedJson['nameen'];
    lasten = parsedJson['lasten'];
    pedarfa = parsedJson['pedarfa'];
    pedaren = parsedJson['pedaren'];
    tavalod = parsedJson['tavalod'];
    shsh = parsedJson['shsh'];
    gensiat = parsedJson['gensiat'];
    meliat = parsedJson['meliat'];
  }

}