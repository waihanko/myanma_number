class MyanmarNumHelper {
  static final MyanmarNumHelper _singleton = MyanmarNumHelper._internal();

  factory MyanmarNumHelper() {
    return _singleton;
  }

  MyanmarNumHelper._internal();

  static List<String> coded = ["GM", "HOT", "YAH"]; //ABV list
  static List<String> decoded = [
    "Gmail",
    "Hotmail",
    "Yahoo"
  ]; //corresponding list
  static Map<String, String> map = Map.fromIterables(coded, decoded);

  // static List<String> numType1 = [
  //   "ကုဋေ",
  //   "သန်း",
  //   "သိန်း",
  //   "သောင်း",
  //   "ထောင်",
  //   "ရာ",
  //   "ဆယ်",
  //   "",
  // ];
  // static List<String> numType2 = [
  //   "ကုဋေ",
  //   "သန်း",
  //   "သိန်း",
  //   "သောင်း",
  //   "ထောင့်",
  //   "ရာ့",
  //   "ဆယ့်",
  //   ""
  // ];

  static List<String> numType1 = [
    "",
    "ဆယ်",
    "ရာ",
    "ထောင်",
    "သောင်း",
    "သိန်း",
    "သန်း",
    "ကုဋေ",
  ];

  static Map<String, String> labelMap = {
    ".": "ဒသမ",
    "0": "သုည",
    "1": "တစ်",
    "2": "နှစ်",
    "3": "သုံး",
    "4": "လေး",
    "5": "ငါး",
    "6": "ခြောက်",
    "7": "ခုနှစ်",
    "8": "ရှစ်",
    "9": "ကိုး"
  };
  static Map<String, String> numberMap = {
    "0": "၀",
    "1": "၁",
    "2": "၂",
    "3": "၃",
    "4": "၄",
    "5": "၅",
    "6": "၆",
    "7": "၇",
    "8": "၈",
    "9": "၉"
  };

  static String getSimpleNumInMM({
    required String number,
    bool isCommaSeparated = false,
  }) {
    if (isCommaSeparated) {
      RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
      String mathFunc(Match match) => '${match[1]},';
      number = number.replaceAllMapped(reg, mathFunc);
    }

    return numberMap.entries
        .fold(number, (prev, e) => prev.toString().replaceAll(e.key, e.value));
  }

  static String getLongTextNumInMM(
      {required String number,
      MMNumberType mmNumberType = MMNumberType.LONGFORM}) {
    String result = "";
    List<String> wholeNumber = number.split(".");

    wholeNumber[0].split("").reversed.toList().asMap().forEach((index, element) {
      if(element == "0") return;
      String prefix = mmNumberType == MMNumberType.LONGFORM
          ? element.trim().getMMDescription
          : element.trim().getMMNumber;
      String postFix = numType1[index];
      result =  prefix + postFix + result ;
    });

    if (wholeNumber.length > 1) {
      result += mmNumberType == MMNumberType.LONGFORM
          ? ".".getMMDescription
          :".". getMMNumber;

      wholeNumber[1].split("").asMap().forEach((index, element) {
        result += mmNumberType == MMNumberType.LONGFORM
            ? element.trim().getMMDescription
            : element.trim(). getMMNumber;
      });
    }

    return result;
  }
}

extension ExtendedString on String {
  String get getMMDescription {
    switch (this) {
      case ".":
        return "ဒသမ";
      case "0":
        return "သုည";
      case "1":
        return "တစ်";
      case "2":
        return "နှစ်";
      case "3":
        return "သုံး";
      case "4":
        return "လေး";
      case "5":
        return "ငါး";
      case "6":
        return "ခြောက်";
      case "7":
        return "ခုနှစ်";
      case "8":
        return "ရှစ်";
      case "9":
        return "ကိုး";
      default:
        return "";
    }
  }

  String get getMMNumber {
    switch (this) {
      case ".":
        return ".";
      case "0":
        return "၀";
      case "1":
        return "၁";
      case "2":
        return "၂";
      case "3":
        return "၃";
      case "4":
        return "၄";
      case "5":
        return "၅";
      case "6":
        return "၆";
      case "7":
        return "၇";
      case "8":
        return "၈";
      case "9":
        return "၉";
      default:
        return "";
    }
  }
}

enum MMNumberType { LONGFORM, SHORTFORM }
