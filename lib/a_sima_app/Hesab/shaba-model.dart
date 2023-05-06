class ShebaModel {
late   String name;
late   String bank;
late   String shobe;
late   String hesab_no;
late   String sheba_no;
late   String status;
late   String soeich;

  ShebaModel.fromJson(Map<String , dynamic> parsedJson) {
    name = parsedJson['namepazirande'];
    bank = parsedJson['bank'];
    shobe = parsedJson['shobe'];
    hesab_no = parsedJson['shhesab'];
    sheba_no = parsedJson['shshaba'];
    status = parsedJson['vaziyat'];
    soeich = parsedJson['panel'];
  }

}