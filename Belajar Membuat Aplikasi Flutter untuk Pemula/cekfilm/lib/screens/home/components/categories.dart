import 'package:flutter/material.dart';

import '../../../constants.dart';

// We need stateful widget because we need to change some sate on our category
class Categorylist extends StatelessWidget {
  final List<String> categories;
  final int selectedCategory;
  final Function(int) onCategoryChanged;

  const Categorylist({
    super.key,
    required this.categories,
    required this.selectedCategory,
    required this.onCategoryChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
      height: 60,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) => buildCategory(index, context),
      ),
    );
  }

  Padding buildCategory(int index, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      child: GestureDetector(
        onTap: () => onCategoryChanged(index),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              categories[index],
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w600,
                fontFamily: 'SansitaSwashed',
                color: index == selectedCategory
                    ? textCategories
                    : textCategories.withOpacity(0.4),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
              height: 6,
              width: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: index == selectedCategory
                    ? kSecondaryColor
                    : Colors.transparent,
              ),
            )
          ],
        ),
      ),
    );
  }
}