import 'package:flutter/material.dart';
import 'package:cekfilm/constants.dart';


import 'categories.dart';
import 'genres.dart';
import 'movie_carousel.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int selectedCategoryIndex = 0;
  final List<String> categories = ["In Theater", "Box Office", "Coming Soon"];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Categorylist(
            categories: categories,
            selectedCategory: selectedCategoryIndex,
            onCategoryChanged: (index) {
              setState(() {
                selectedCategoryIndex = index;
              });
            },
          ),
          Genres(),
          SizedBox(height: kDefaultPadding),
          MovieCarousel(status: categories[selectedCategoryIndex]),
        ],
      ),
    );
  }
}
