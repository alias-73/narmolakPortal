class ChangeModel {
  late String foroshgahfaold;
  late String foroshgahfanew;
  late String foroshgahenold;
  late String foroshgahennew;
  late String tellpishold;
  late String tellpishnew;
  late String tellold;
  late String tellnew;
  late String mobilepishold;
  late String mobilepishnew;
  late String mobileold;
  late String mobilenew;
  late String status;
  late String terminal;
  late String desc;

  ChangeModel.fromJson(Map < String , dynamic> parsedJson) {
    foroshgahfaold = parsedJson['foroshgahfaold'];
    foroshgahfanew= parsedJson['foroshgahfanew'];
    foroshgahenold = parsedJson['foroshgahenold'];
    foroshgahennew= parsedJson['foroshgahennew'];
    tellpishold = parsedJson['tellpishold'];
    tellpishnew= parsedJson['tellpishnew'];
    tellold = parsedJson['tellold'];
    tellnew= parsedJson['tellnew'];
    mobilepishold = parsedJson['mobilepishold'];
    mobilepishnew= parsedJson['mobilepishnew'];
    mobileold = parsedJson['mobileold'];
    mobilenew= parsedJson['mobilenew'];
    status = parsedJson['vaziyat'];
    terminal = parsedJson['terminal'];
    desc = parsedJson['tozihat'];
  }

}