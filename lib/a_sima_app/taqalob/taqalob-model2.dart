class TaqalobModel2 {
  late String rahgiri;
  late String date;
  late String terminal;
  late String P_Name;
  late String F_Name;
  late String tell;
  late String mobile;
  late String ostan;
  late String shahr;
  late String address;
  late String sharh;

  TaqalobModel2.fromJson(Map< String , dynamic> parsedJson) {
    rahgiri = parsedJson['rahgiri'];
    date = parsedJson['tarikh'];
    terminal = parsedJson['terminal'];
    P_Name = parsedJson['pazirandename'];
    F_Name= parsedJson['foroshgahname'];
    tell= parsedJson['tell'];
    mobile= parsedJson['mobile'];
    ostan= parsedJson['ostan'];
    shahr= parsedJson['shahr'];
    address = parsedJson['address'];
    sharh = parsedJson['sharh'];
  }

}