import '../../../../../core/resources/assets_manager.dart';

class BookLevel {
  /// The underlying value of this enum member.
  int value = 0;

  BookLevel._internal(this.value);

  static BookLevel a = BookLevel._internal(1);
  static BookLevel b = BookLevel._internal(2);
  static BookLevel c = BookLevel._internal(3);
  static BookLevel d = BookLevel._internal(4);
  static BookLevel e = BookLevel._internal(5);
  static BookLevel f = BookLevel._internal(6);
  static BookLevel g = BookLevel._internal(7);
  static BookLevel h = BookLevel._internal(8);
  static BookLevel i = BookLevel._internal(9);
  static BookLevel j = BookLevel._internal(10);
  static BookLevel k = BookLevel._internal(11);
  static BookLevel l = BookLevel._internal(12);
  static BookLevel m = BookLevel._internal(13);
  static BookLevel n = BookLevel._internal(14);
  static BookLevel o = BookLevel._internal(15);
  static BookLevel p = BookLevel._internal(16);
  static BookLevel q = BookLevel._internal(17);
  static BookLevel r = BookLevel._internal(18);
  static BookLevel s = BookLevel._internal(19);

  // static final List<BookLevel> availableValues = [
  //   egypt,
  //   canada,
  //   poland,
  //   usa,
  // ];

  String get level {
    switch (value) {
      case 1:
        return ImageAssets.charA;
      case 2:
        return ImageAssets.charB;
      case 3:
        return ImageAssets.charC;
      case 4:
        return ImageAssets.charD;
      case 5:
        return ImageAssets.charE;
      case 6:
        return ImageAssets.charF;
      case 7:
        return ImageAssets.charG;
      case 8:
        return ImageAssets.charH;
      case 9:
        return ImageAssets.charI;
      case 10:
        return ImageAssets.charJ;
      case 11:
        return ImageAssets.charK;
      case 12:
        return ImageAssets.charL;
      case 13:
        return ImageAssets.charM;
      case 14:
        return ImageAssets.charN;
      case 15:
        return ImageAssets.charO;
      case 16:
        return ImageAssets.charP;
      case 17:
        return ImageAssets.charQ;
      case 18:
        return ImageAssets.charR;
      case 19:
        return ImageAssets.charS;
      default:
        return ImageAssets.charA;
    }
  }

  BookLevel.fromJson(dynamic data) {
    switch (data) {
      case 0:
        value = data;
        break;
      case 1:
        value = data;
        break;
      case 2:
        value = data;
        break;
      case 3:
        value = data;
        break;
      default:
        throw ('Unknown enum value to decode BookLevel : $data');
    }
  }

  static dynamic encode(BookLevel data) {
    return data.value;
  }
}
