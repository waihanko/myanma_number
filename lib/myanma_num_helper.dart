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

  List<String> numType1 = [
    "ခု",
    "ဆယ်",
    "ရာ",
    "ထောင်",
    "သောင်း",
    "သိန်း",
    "သန်း",
    "ကုဋေ"
  ];
  List<String> numType2 = [
    "ခု",
    "ဆယ့်",
    "ရာ့",
    "ထောင့်",
    "သောင်း",
    "သိန်း",
    "သန်း",
    "ကုဋေ"
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
    String result = number;

    if (isCommaSeparated) {
      RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
      String mathFunc(Match match) => '${match[1]},';
      result = number.replaceAllMapped(reg, mathFunc);
    }
    return numberMap.entries
        .fold(result, (prev, e) => prev.toString().replaceAll(e.key, e.value));
  }

  static String getLabeledNumInMM() {
    return "Hello Myanmar I am Text";
  }
}
