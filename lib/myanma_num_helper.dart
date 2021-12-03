class MyanmarNumHelper {
  static final MyanmarNumHelper _singleton = MyanmarNumHelper._internal();

  factory MyanmarNumHelper() {
    return _singleton;
  }

  MyanmarNumHelper._internal();


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
      {required String number, MMNumberType mmNumberType = MMNumberType.TEXT}) {
    String result = "";
    List<String> wholeNumber = number.split(".");

    if (wholeNumber[0].length >= 3 && !wholeNumber[0].endsWith("0")) {
      numType1[1] = "ဆယ့်";
    }
    if (wholeNumber[0].length >= 4 && !wholeNumber[0].endsWith("00")) {
      numType1[2] = "ရာ့";
    }
    if (wholeNumber[0].length >= 5 && !wholeNumber[0].endsWith("0000")) {
      numType1[3] = "ထောင့်";
    }

    wholeNumber[0]
        .split("")
        .reversed
        .toList()
        .asMap()
        .forEach((index, element) {
      if (element == "0") return;
      String prefix = mmNumberType == MMNumberType.TEXT
          ? element.trim().getMMDescription
          : element.trim().getMMNumber;
      String postFix = numType1[index];
      result = prefix + postFix + result;
    });

    if (wholeNumber.length > 1) {
      result += mmNumberType == MMNumberType.TEXT
          ? ".".getMMDescription
          : ".".getMMNumber;

      wholeNumber[1].split("").asMap().forEach((index, element) {
        result += mmNumberType == MMNumberType.TEXT
            ? element.trim().getMMDescription
            : element.trim().getMMNumber;
      });
    }

    return result;
  }

  //Over 8 && NORMAL => Change To THEIN
  //Over 10 && THEIN => Change To THAN
  //Over 12 && THAN => Change To GADAY
  //Over 14 is Invalid

  static String getLongTextNumInMM2({
    required String number,
    MMNumberType mmNumberType = MMNumberType.TEXT,
  }) {
    String result = "";
    DisplayFormat displayFormat = DisplayFormat.DEFAULT;
        List<String> wholeNumber = number.split(".");
    if (wholeNumber[0].length > 14) {
      return "INVALID AMOUNT";
    } else if (wholeNumber[0].length > 12 &&
        displayFormat == DisplayFormat.THAN) {
      displayFormat = DisplayFormat.GADAY;
    } else if (wholeNumber[0].length > 10 &&
        displayFormat == DisplayFormat.THEIN) {
      displayFormat = DisplayFormat.THAN;
    } else if (wholeNumber[0].length > 8 &&
        displayFormat == DisplayFormat.DEFAULT) {
      displayFormat = DisplayFormat.GADAY;
    }

    result += getFullNumber(
        wholeNumber[0].substring(
            0, wholeNumber[0].length - displayFormat.getPartition.index),
        mmNumberType,
        wholeNumber[0].length);

    if (wholeNumber[0]
        .substring(0, wholeNumber[0].length - displayFormat.getPartition.index)
        .endsWith("0")) {
      result = displayFormat.getPartition.name + result;
    } else {
      result = result + displayFormat.getPartition.name;
    }

    result += getFullNumber(
        wholeNumber[0].substring(
            wholeNumber[0].length - displayFormat.getPartition.index,
            wholeNumber[0].length),
        mmNumberType,
        wholeNumber[0].length);

    if (wholeNumber.length > 1) {
      result += mmNumberType == MMNumberType.TEXT
          ? ".".getMMDescription
          : ".".getMMNumber;

      wholeNumber[1].split("").asMap().forEach((index, element) {
        result += mmNumberType == MMNumberType.TEXT
            ? element.trim().getMMDescription
            : element.trim().getMMNumber;
      });
    }

    return result;
  }

  static String getFullNumber(
    String wholeNumber,
    MMNumberType mmNumberType,
    int digitCount,
  ) {
    String result = "";
    List<String> numType2 = List.of(numType1);

    if (digitCount >= 2 && !wholeNumber.endsWith("0")) {
      numType2[1] = "ဆယ့်";
    }
    if (digitCount >= 3 && !wholeNumber.endsWith("00")) {
      numType2[2] = "ရာ့";
    }
    if (digitCount >= 4 && !wholeNumber.endsWith("000")) {
      numType2[3] = "ထောင့်";
    }

    wholeNumber.split("").reversed.toList().asMap().forEach((index, element) {
      if (element == "0") return;
      String prefix = mmNumberType == MMNumberType.TEXT
          ? element.trim().getMMDescription
          : element.trim().getMMNumber;
      String postFix = numType2[index];
      result = prefix + postFix + result;
    });
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

extension DisplayFormatExt on DisplayFormat {
  DisplayFormatVo get getPartition {
    switch (this) {
      case DisplayFormat.THEIN:
        return DisplayFormatVo(5, "သိန်း");
      case DisplayFormat.THAN:
        return DisplayFormatVo(6, "သန်း");
      case DisplayFormat.GADAY:
        return DisplayFormatVo(7, "ကုဋေ");
      case DisplayFormat.DEFAULT:
        return DisplayFormatVo(0, "");
      default:
        return DisplayFormatVo(0, "");
    }
  }
}

class DisplayFormatVo {
  final int index;
  final String name;

  DisplayFormatVo(this.index, this.name);
}

enum MMNumberType { TEXT, NUMBER }
enum DisplayFormat { THEIN, THAN, GADAY, DEFAULT }
