class ChangeModel2 {
  late String bankaold;
  late String banknew;
  late String shobeold;
  late String shobenew;
  late String hesabold;
  late String hesabnew;
  late String shebaold;
  late String shebanew;
  late String status;
  late String name;
  late String terminal;

  ChangeModel2.fromJson(Map < String , dynamic> parsedJson) {
    bankaold = parsedJson['bankold'];
    banknew= parsedJson['banknew'];
    shobeold = parsedJson['shobeold'];
    shobenew= parsedJson['shobenew'];
    hesabold = parsedJson['hesabold'];
    hesabnew= parsedJson['hesabnew'];
    shebaold = parsedJson['shabaold'];
    shebanew= parsedJson['shabanew'];
    name = parsedJson['name'];
    status = parsedJson['vaziyat'];
    terminal = parsedJson['terminal'];
  }

}