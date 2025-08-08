import 'package:flutter/material.dart';
import 'package:cekfilm/constants.dart';
import 'package:cekfilm/data/data.dart';

import 'backdrop_rating.dart';
import 'cast_and_crew.dart';
import 'genres.dart';
import 'title_duration_and_fav_btn.dart';

class Body extends StatelessWidget {
  final Movie movie;

  const Body({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double maxWidth = constraints.maxWidth;

        return SingleChildScrollView(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 900), // batas maksimum konten
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                   BackdropAndRating(
                    size: MediaQuery.of(context).size,
                    movie: movie,
                  ),

                  const SizedBox(height: kDefaultPadding / 2),


                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                    child: TitleDurationAndFabBtn(movie: movie),
                  ),


                  Genres(movie: movie),


                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: kDefaultPadding / 2,
                      horizontal: kDefaultPadding,
                    ),
                    child: Text(
                      "Sinopsis",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Roboto',
                        color: kTextColor,
                      ),
                    ),
                  ),


                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                    child: Text(
                      movie.plot,
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontSize: maxWidth < 600 ? 14 : 16,
                        color: kTextColor,
                        fontFamily: 'OpenSans',
                      ),
                    ),
                  ),

                  const SizedBox(height: kDefaultPadding),


                  CastAndCrew(casts: movie.cast),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

