import 'package:flutter/material.dart';
import 'package:cekfilm/data/data.dart';

import '../../../constants.dart';

class TitleDurationAndFabBtn extends StatelessWidget {
  const TitleDurationAndFabBtn({
    Key? key,
    required this.movie,
  }) : super(key: key);

  final Movie movie;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(kDefaultPadding),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  movie.title,
                  //style: Theme.of(context).textTheme.headlineSmall,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Roboto',
                    color: textColor,
                  ),
                ),
                SizedBox(height: kDefaultPadding / 2),
                Row(
                  children: <Widget>[
                    Text(
                      '🇮🇩',
                      style: TextStyle(color: kTextLightColor),
                    ),
                    SizedBox(width: kDefaultPadding),
                    Text(
                        '${movie.year}',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        color: kTextLightColor,
                      ),
                    ),
                    SizedBox(width: kDefaultPadding),
                    Text(
                      '${movie.pg}',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        color: kTextLightColor,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          OutlinedButton.icon(
            onPressed: () => "",
            style: OutlinedButton.styleFrom(
              foregroundColor: textCategories,
              side: const BorderSide(color: bgBorderGenre),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            ),
            icon: const Icon(Icons.play_arrow),
            label: const Text("Trailer"),
          ),

        ],
      ),
    );
  }
}
