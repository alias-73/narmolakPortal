class BankModel {
  late String bankName;

  BankModel.fromJson(Map < String , dynamic> parsedJson) {
    bankName = parsedJson['name'];
  }

}