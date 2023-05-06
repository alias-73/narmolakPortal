class AfterTakhsisModel {
  late String store;
  late String terminal;

  AfterTakhsisModel.fromJson(Map < String , dynamic> parsedJson) {
    store = parsedJson['foroshgah'];
    terminal = parsedJson['terminal'];
  }

}