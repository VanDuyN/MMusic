import 'dart:ui';
class TColor{
  static Color get primary => const Color(0xff06A0B5);
  static Color get primary20 => primary.withOpacity(0.2);
  static Color get primary30 => primary.withOpacity(0.3);
  static Color get primary40 => primary.withOpacity(0.4);

  static Color get focus => const Color(0xffD9519D);
  static Color get unfocused => const Color(0xff63666E);
  static Color get focusStart => const Color(0xffC35BD1);

  static Color get secondaryStart => primary;
  static Color get secondaryEnd => const Color(0xff657DDF);

  static Color get org => const Color(0xffE1914B);
  static Color get primaryItem20 => const Color(0xff436369).withOpacity(0.2);

  static Color get primaryText => const Color(0xffFFFFFF);

  static Color get primaryTextM => const Color(0xff00C2CB);
  static Color get primaryTextTitleColor=> const Color(0xff39C0D4);

  static Color get primaryText80 => const Color(0xffFFFFFF).withOpacity(0.8);
  static Color get primaryText60 => const Color(0xffFFFFFF).withOpacity(0.6);
  static Color get primaryText35 => const Color(0xffFFFFFF).withOpacity(0.35);
  static Color get primaryText28 => const Color(0xffFFFFFF).withOpacity(0.28);
  static Color get secondaryText => const Color(0xffFFFFFF);

  static Color get primaryTopIcon => const Color(0xffA6F3FF);
  static Color get primaryBottomIcon => const Color(0xff00C2CB);

  static List<Color> get primaryG => [focusStart,focus];
  static List<Color> get secondaryG => [secondaryStart,secondaryEnd];

  static Color get bg => const Color(0xff000000);
  static Color get darkGray => const Color(0xff383849);
  static Color get lightGray => const Color(0xffD0D1D4);

}
extension HexColor on Color{
  static Color fromHex (String hexString){
    final buffer = StringBuffer();
    if(hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceAll('#', ''));
    return Color(int.parse(buffer.toString(),radix: 16));
  }
  String toHex({bool leadingHashSign = true})=> '${leadingHashSign ? '#': ''}'
      '${alpha.toRadixString(16).padLeft(2,'0')}'
      '${red.toRadixString(16).padLeft(2,'0')}'
      '${green.toRadixString(16).padLeft(2,'0')}'
      '${blue.toRadixString(16).padLeft(2,'0')}';
}