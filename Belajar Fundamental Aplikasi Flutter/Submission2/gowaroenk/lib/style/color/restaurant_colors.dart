import 'package:flutter/material.dart';

enum RestaurantColors {
  primary("Primary", Color(0xFF003285)),
  secondary("Secondary", Color(0xFFFF7043)),
  secondaryBlue("Secondary Blue", Color(0xFF2A629A)),
  accentOrange("Accent Orange", Color(0xFFFF7F3E)),
  softYellow("Soft Yellow", Color(0xFFFFDA78)),

  white("White", Color(0xFFFFFFFF)),
  black("Black", Color(0xFF000000)),
  greyLight("Grey Light", Color(0xFFE0E0E0)),
  greyMedium("Grey Medium", Color(0xFF9E9E9E)),
  gold("Gold", Color(0xFFFFD700)),
  greyDark("Grey Dark", Color(0xFF616161));

  const RestaurantColors(this.name, this.color);

  final String name;
  final Color color;
}
