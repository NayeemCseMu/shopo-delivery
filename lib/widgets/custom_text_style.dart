import 'dart:ui';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class KTextStyle {
  static sourceOpenPro(
          {required double fs, required Color c, required FontWeight fw}) =>
      GoogleFonts.sourceSansPro(fontWeight: fw, fontSize: fs.sp, color: c);

  static inter(
          {required double fs, required Color c, required FontWeight fw}) =>
      GoogleFonts.inter(fontWeight: fw, fontSize: fs.sp, color: c);

  static roboto(
          {required double fs, required Color c, required FontWeight fw}) =>
      GoogleFonts.roboto(fontWeight: fw, fontSize: fs.sp, color: c);
}
