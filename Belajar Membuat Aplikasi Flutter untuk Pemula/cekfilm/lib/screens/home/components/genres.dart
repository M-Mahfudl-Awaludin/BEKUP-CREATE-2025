import 'package:flutter/material.dart';
import 'package:cekfilm/components/genre_card.dart';

import '../../../constants.dart';

class Genres extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<String> genres = [
      "Action",
      "Adventure",
      "Animation",
      "Biography",
      "Comedy",
      "Crime",
      "Documentary",
      "Drama",
      "Family",
      "Fantasy",
      "History",
      "Horror",
      "Music",
      "Musical",
      "Mystery",
      "Romance",
      "Sci-Fi",
      "Sport",
      "Thriller",
      "War",
      "Western"
    ];
    return Container(
      margin: EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
      height: 36,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: genres.length,
        itemBuilder: (context, index) => GenreCard(genre: genres[index]),
      ),
    );
  }
}
