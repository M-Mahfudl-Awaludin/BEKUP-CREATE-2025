import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cekfilm/data/data.dart';
import '../../../constants.dart';

class BackdropAndRating extends StatelessWidget {
  const BackdropAndRating({
    Key? key,
    required this.size,
    required this.movie,
  }) : super(key: key);

  final Size size;
  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double width = constraints.maxWidth;

        // responsive height
        double backdropHeight = width > 900
            ? 500
            : width > 600
            ? 400
            : 300;

        return SizedBox(
          height: backdropHeight + 90,
          child: Stack(
            children: <Widget>[

              Container(
                height: backdropHeight,
                decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(movie.backdrop),
                  ),
                ),
              ),


              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  width: double.infinity, // FULL WIDTH
                  height: 90,
                  decoration: BoxDecoration(
                    color: bgColor1.withOpacity(0.3), // semi transparan abu
                      borderRadius: const BorderRadius.vertical(
                        bottom: Radius.circular(20),
                      ),
                    boxShadow: [
                      BoxShadow(
                        color: bgColor1.withOpacity(0.7),
                        blurRadius: 6,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _InfoColumn(
                          icon: SvgPicture.asset("assets/icons/star_fill.svg"),
                          label: "${movie.rating}/10",
                        ),
                        const SizedBox(width: 24),
                        _InfoColumn(
                          icon: const Icon(Icons.access_time, size: 24, color: Color(0xFFE6521F)),
                          label: movie.durasi,
                        ),
                        const SizedBox(width: 24),
                        _InfoColumn(
                          icon: const Icon(Icons.calendar_today, size: 24, color: Color(0xFFE6521F)),
                          label: movie.tglRilis,
                        ),
                      ],
                    ),
                  ),
                ),
              ),


              //const SafeArea(child: BackButton()),
              SafeArea(
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: SvgPicture.asset(
                      "assets/icons/back.svg",
                      height: 40,
                      width: 40,
                    ),
                  ),
                ),
              ),

            ],
          ),
        );
      },
    );
  }
}

class _InfoColumn extends StatelessWidget {
  final Widget icon;
  final String label;

  const _InfoColumn({
    Key? key,
    required this.icon,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        icon,
        const SizedBox(height: 6),
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: textCategories,
            fontFamily: 'Roboto',
          ),
        ),
      ],
    );
  }
}
