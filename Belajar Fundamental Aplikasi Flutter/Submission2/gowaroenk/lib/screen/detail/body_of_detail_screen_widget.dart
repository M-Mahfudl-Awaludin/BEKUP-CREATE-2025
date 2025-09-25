import 'package:flutter/material.dart';
import 'package:gowaroenk/data/model/restaurant.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../provider/detail/add_review_restaurant_provider.dart';
import '../../style/color/restaurant_colors.dart';
import 'add_review_widget.dart';
import 'package:gowaroenk/screen/detail/expandable_text.dart';

import 'bookmark_icon_widget.dart';

class BodyOfDetailScreenWidget extends StatelessWidget {
  const BodyOfDetailScreenWidget({super.key, required this.restaurant});

  final Restaurant restaurant;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 250,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  fit: StackFit.expand,
                  children: [
                    Hero(
                      tag: 'restaurantImage-${restaurant.id}',
                      child: ClipRRect(
                        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(16)),
                        child: Image.network(
                          restaurant.image,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.broken_image, size: 80),
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            RestaurantColors.black.color.withValues(alpha:0.5),
                          ],
                        ),
                        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(16)),
                      ),
                    ),
                    Positioned(
                      left: 16,
                      bottom: 16,
                      right: 16,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Text(
                              restaurant.name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Lottie.asset(
                                'assets/lottie/stars.json',
                                width: 30,
                                height: 30,
                                repeat: true,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                restaurant.rating.toString(),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: RestaurantColors.gold.color, // teks emas
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Lottie.asset(
                          'assets/lottie/locate.json',
                          width: 30,
                          height: 30,
                          repeat: true,
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                restaurant.city,
                                style: Theme.of(context)
                                    .textTheme
                                    .labelLarge
                                    ?.copyWith(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 0.5),
                              Text(
                                restaurant.address ?? '',
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: RestaurantColors.greyMedium.color,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        // 👉 Tombol Bookmark
                        BookmarkIconWidget(restaurant: restaurant),
                      ],
                    ),


                    const SizedBox(height: 16),
                    const TabBar(
                      tabs: [
                        Tab(text: 'Detail'),
                        Tab(text: 'Rating'),
                      ],
                    ),


                    SizedBox(
                      height: 600, // Tinggi tab view
                      child: TabBarView(
                        children: [
                          SingleChildScrollView(
                            padding: const EdgeInsets.only(top: 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ExpandableTextWidget(
                                  text: restaurant.description,
                                  maxLines: 4, // tampil 4 baris dulu
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  'Kategori',
                                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Wrap(
                                  spacing: 8,
                                  runSpacing: 6,
                                  children: restaurant.categories?.map((cat) {
                                    return Chip(
                                      label: Text(
                                        cat.name,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall
                                            ?.copyWith(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w500,
                                            color: RestaurantColors.secondary.color,
                                        )
                                      ),
                                      backgroundColor: Colors.transparent,
                                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        side: BorderSide(
                                          color: RestaurantColors.accentOrange.color,
                                          width: 1.5,
                                        ),
                                      ),
                                      avatar: Icon(
                                        Icons.category,
                                        size: 18,
                                        color: RestaurantColors.softYellow.color,
                                      ),
                                    );
                                  }).toList() ??
                                      [const Text('-')],
                                ),

                                const SizedBox(height: 12),
                                Text(
                                  'Menu Makanan',
                                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),

                                SizedBox(
                                  height: 100,
                                  child: ListView(
                                    scrollDirection: Axis.horizontal,
                                    children: restaurant.menus?.foods.map((food) {
                                      return Padding(
                                        padding: const EdgeInsets.only(right: 12),
                                        child: Column(
                                          children: [
                                            Container(
                                              width: 60,
                                              height: 60,
                                              decoration: BoxDecoration(
                                                color: Colors.orange.shade100,
                                                shape: BoxShape.circle,
                                              ),
                                              child: const Icon(
                                                Icons.fastfood,
                                                size: 32,
                                                color: Colors.deepOrange,
                                              ),
                                            ),
                                            const SizedBox(height: 6),
                                            Text(
                                              food.name,
                                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ],
                                        ),
                                      );
                                    }).toList() ??
                                        [const Text('-')],
                                  ),
                                ),

                                const SizedBox(height: 16),
                                Text(
                                  'Menu Minuman',
                                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                    fontWeight: FontWeight.bold,
                                      color: RestaurantColors.greyDark.color
                                  ),
                                ),
                                const SizedBox(height: 8),

                                SizedBox(
                                  height: 100,
                                  child: ListView(
                                    scrollDirection: Axis.horizontal,
                                    children: restaurant.menus?.drinks.map((drink) {
                                      return Padding(
                                        padding: const EdgeInsets.only(right: 12),
                                        child: Column(
                                          children: [
                                            Container(
                                              width: 60,
                                              height: 60,
                                              decoration: BoxDecoration(
                                                color: Colors.blue.shade100,
                                                shape: BoxShape.circle,
                                              ),
                                              child: const Icon(
                                                Icons.local_drink,
                                                size: 32,
                                                color: Colors.blueAccent,
                                              ),
                                            ),
                                            const SizedBox(height: 6),

                                            Text(
                                              drink.name,
                                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    }).toList() ??
                                        [const Text('-')],
                                  ),
                                ),

                              ],
                            ),
                          ),

                          SingleChildScrollView(
                            padding: const EdgeInsets.only(top: 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: ElevatedButton.icon(
                                    onPressed: () async {
                                      final provider = context.read<AddReviewRestaurantProvider>();
                                      final result = await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => AddReviewWidget(restaurantId: restaurant.id),
                                        ),
                                      );
                                      if (result == true) {
                                        if (!context.mounted) return;
                                        provider.addReview(
                                          restaurant.id,
                                          '',
                                          '',
                                        );
                                      }
                                    },
                                    icon: const Icon(Icons.add_comment),
                                    label: Text(
                                      "Add Review",
                                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                        color: Theme.of(context).colorScheme.onPrimary,
                                      ),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Theme.of(context).colorScheme.primary,
                                      foregroundColor: Theme.of(context).colorScheme.onPrimary,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 12),

                                Consumer<AddReviewRestaurantProvider>(
                                  builder: (context, provider, child) {
                                    final reviews = provider.reviews.isNotEmpty
                                        ? provider.reviews
                                        : restaurant.customerReviews ?? [];

                                    if (reviews.isEmpty) {
                                      return Center(
                                        child: Text(
                                          'Belum ada ulasan',
                                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                            color: Theme.of(context).colorScheme.onSurface,
                                          ),
                                        ),
                                      );
                                    }

                                    return ListView.builder(
                                      shrinkWrap: true,
                                      physics: const NeverScrollableScrollPhysics(),
                                      itemCount: reviews.length,
                                      itemBuilder: (_, index) {
                                        final review = reviews[index];
                                        return Card(
                                          margin: const EdgeInsets.symmetric(vertical: 6),
                                          child: ListTile(
                                            title: Text(
                                              review.name,
                                              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            subtitle: Text(
                                              review.review,
                                              style: Theme.of(context).textTheme.bodySmall,
                                            ),
                                            trailing: Text(
                                              review.date,
                                              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                                color: Theme.of(context).colorScheme.secondary,
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                )

                              ]
                          ),
                          ),

                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}