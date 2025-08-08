import 'package:flutter/material.dart';

import '../constants.dart';

class GenreCard extends StatelessWidget {
  final String genre;

  const GenreCard({Key? key, required this.genre}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(left: kDefaultPadding),
      padding: EdgeInsets.symmetric(
        horizontal: kDefaultPadding,
        vertical: kDefaultPadding / 4, // 5 padding top and bottom
      ),
      decoration: BoxDecoration(
        color: bgColor1.withOpacity(0.15),
        border: Border.all(color: bgBorderGenre),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Text(
        genre,
        style: TextStyle(color: textColor.withOpacity(0.9),
            fontSize: 16,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
          fontFamily: 'SansitaSwashed',
        ),
      ),
    );
  }
}
