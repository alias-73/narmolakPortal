class TaqalobModel {
  late String rahgiri;
  late String date;
  late String terminal;
  late String P_Name;
  late String F_Name;

  TaqalobModel.fromJson(Map< String , dynamic> parsedJson) {
    rahgiri = parsedJson['rahgiri'];
    date = parsedJson['tarikh'];
    terminal = parsedJson['terminal'];
    P_Name = parsedJson['pazirandename'];
    F_Name= parsedJson['foroshgahname'];
  }

}