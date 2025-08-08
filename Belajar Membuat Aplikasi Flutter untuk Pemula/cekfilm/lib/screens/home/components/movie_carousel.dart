import 'package:flutter/material.dart';
import 'package:cekfilm/data/data.dart';
import '../../../constants.dart';
import 'movie_card.dart';

class MovieCarousel extends StatelessWidget {
  final String status;

  const MovieCarousel({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    const double cardAspectRatio = 0.6;
    final bool isMobile = screenWidth < 600;

    final filteredMovies = movies
        .where((movie) => movie.status == status)
        .toList();

    if (isMobile) {
      final double cardWidth = screenWidth * 0.85;
      final double cardHeight = cardWidth / cardAspectRatio;

      return SizedBox(
        height: cardHeight + 70,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: filteredMovies.length,
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.only(right: kDefaultPadding),
            child: SizedBox(
              width: cardWidth,
              child: MovieCard(movie: filteredMovies[index]),
            ),
          ),
        ),
      );
    } else {
      final double cardWidth = screenWidth / 5;
      final int crossAxisCount = (screenWidth / cardWidth).floor();

      return Padding(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: filteredMovies.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            childAspectRatio: cardAspectRatio,
            crossAxisSpacing: kDefaultPadding,
            mainAxisSpacing: kDefaultPadding,
          ),
          itemBuilder: (context, index) =>
              MovieCard(movie: filteredMovies[index]),
        ),
      );
    }
  }
}

