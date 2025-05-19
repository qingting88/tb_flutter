import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

// - assets/icons/email.svg
// - assets/icons/phone.svg
// - assets/icons/smartphone.svg

class SvgIcons {
  static final SvgPicture logo = SvgPicture.asset(
    'assets/icons/logo.svg',
    semanticsLabel: 'logo',
    colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
  );
  static final SvgPicture padlock = SvgPicture.asset(
    'assets/icons/padlock.svg',
    semanticsLabel: 'padlock',
  );
  static final SvgPicture passport = SvgPicture.asset(
    'assets/icons/passport.svg',
    semanticsLabel: 'passport',
  );
  static final SvgPicture quit = SvgPicture.asset(
    'assets/icons/quit.svg',
    semanticsLabel: 'quit',
  );
  static final SvgPicture arrowBlackRight = SvgPicture.asset(
    'assets/icons/arrow-black-right.svg',
    semanticsLabel: 'arrow-black-right',
  );
  static final SvgPicture email = SvgPicture.asset(
    'assets/icons/email.svg',
    semanticsLabel: 'email',
  );
  static final SvgPicture google = SvgPicture.asset(
    'assets/icons/google.svg',
    semanticsLabel: 'google',
  );
  static final SvgPicture smartphone = SvgPicture.asset(
    'assets/icons/smartphone.svg',
    semanticsLabel: 'smartphone',
  );
  static final SvgPicture copy = SvgPicture.asset(
    'assets/icons/copy.svg',
    semanticsLabel: 'copy',
  );

  static final SvgPicture ios = SvgPicture.asset(
    'assets/icons/ios.svg',
    semanticsLabel: 'ios',
  );
  static final SvgPicture android = SvgPicture.asset(
    'assets/icons/android.svg',
    semanticsLabel: 'android',
  );
}
