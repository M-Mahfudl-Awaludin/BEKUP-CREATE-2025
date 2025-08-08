import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cekfilm/data/data.dart';
import 'package:cekfilm/screens/details/details_screen.dart';
import '../../../constants.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;

  const MovieCard({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
      child: OpenContainer(
        closedElevation: 0,
        openElevation: 0,
        closedBuilder: (context, action) => buildMovieCard(context),
        openBuilder: (context, action) => DetailsScreen(movie: movie),
      ),
    );
  }

  Widget buildMovieCard(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double imageHeight = constraints.maxHeight * 0.75;

        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: imageHeight,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                boxShadow: [kDefaultShadow],
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(movie.poster),
                ),
              ),
            ),
            const SizedBox(height: kDefaultPadding / 2),
            Text(
              movie.title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 6),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  "assets/icons/star_fill.svg",
                  height: 18,
                ),
                const SizedBox(width: 6),
                Text(
                  "${movie.rating}",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
