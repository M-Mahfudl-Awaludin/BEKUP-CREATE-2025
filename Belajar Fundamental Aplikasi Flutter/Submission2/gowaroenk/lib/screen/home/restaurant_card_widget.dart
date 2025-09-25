import 'package:flutter/material.dart';
import 'package:gowaroenk/data/model/restaurant.dart';
import 'package:lottie/lottie.dart';
import '../../style/color/restaurant_colors.dart';

class RestaurantCard extends StatelessWidget {
  final Restaurant restaurant;
  final Function() onTap;

  const RestaurantCard({
    super.key,
    required this.restaurant,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        height: 160,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.15),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Stack(
            children: [
              Positioned.fill(
                child: Hero(
                  tag: 'restaurantImage-${restaurant.id}',
                  child: Image.network(
                    restaurant.image,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: RestaurantColors.greyLight.color,
                      child: Icon(
                        Icons.broken_image,
                        size: 50,
                        color: RestaurantColors.greyMedium.color,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned.fill(
                child: Container(
                  color: RestaurantColors.black.color.withValues(alpha: 0.5),
                ),
              ),
              Positioned(
                left: 12,
                right: 12,
                bottom: 38,
                child: Text(
                  restaurant.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: RestaurantColors.white.color,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  color: RestaurantColors.black.color.withValues(alpha:0.5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 16,
                            height: 16,
                            child: Lottie.asset(
                              'assets/lottie/locate.json',
                              repeat: true,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            restaurant.city,
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: RestaurantColors.greyLight.color,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 35,
                            height: 18,
                            child: Lottie.asset(
                              'assets/lottie/stars.json',
                              repeat: true,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            restaurant.rating.toString(),
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: RestaurantColors.gold.color,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
