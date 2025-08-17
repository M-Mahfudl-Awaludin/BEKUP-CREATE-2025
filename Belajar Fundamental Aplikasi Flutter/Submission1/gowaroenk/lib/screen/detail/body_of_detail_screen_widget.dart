import 'package:flutter/material.dart';
import 'package:gowaroenk/data/model/restaurant.dart';

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
                title: Text(restaurant.name),
                background: ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                      bottom: Radius.circular(16)),
                  child: Image.network(
                    restaurant.image,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.broken_image, size: 80),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Kota & Rating
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          restaurant.city,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(fontWeight: FontWeight.w500),
                        ),
                        Row(
                          children: [
                            const Icon(Icons.star,
                                color: Colors.amber, size: 20),
                            const SizedBox(width: 4),
                            Text(
                              restaurant.rating.toString(),
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    // Tab Bar
                    TabBar(
                      indicatorColor: Colors.amber,
                      labelColor: Colors.black,
                      unselectedLabelColor: Colors.grey,
                      tabs: const [
                        Tab(text: 'Detail'),
                        Tab(text: 'Rating'),
                      ],
                    ),
                    SizedBox(
                      height: 400, // Tinggi tab view
                      child: TabBarView(
                        children: [
                          // Tab Detail
                          SingleChildScrollView(
                            padding: const EdgeInsets.only(top: 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  restaurant.description,
                                  style:
                                  Theme.of(context).textTheme.bodyMedium,
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  'Kategori',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 8),
                                Wrap(
                                  spacing: 8,
                                  children: restaurant.categories
                                      ?.map((cat) => Chip(
                                    label: Text(cat.name),
                                  ))
                                      .toList() ??
                                      [const Text('-')],
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  'Menu Makanan',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 8),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: restaurant.menus?.foods
                                      .map((food) => Text('- ${food.name}'))
                                      .toList() ??
                                      [const Text('-')],
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  'Menu Minuman',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 8),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: restaurant.menus?.drinks
                                      .map((drink) =>
                                      Text('- ${drink.name}'))
                                      .toList() ??
                                      [const Text('-')],
                                ),
                              ],
                            ),
                          ),
                          // Tab Rating
                          SingleChildScrollView(
                            padding: const EdgeInsets.only(top: 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,

                              children: restaurant.customerReviews
                                  ?.map(
                                    (review) => Card(
                                  margin:
                                  const EdgeInsets.symmetric(
                                      vertical: 6),
                                  child: ListTile(
                                    title: Text(review.name),
                                    subtitle: Text(review.review),
                                    trailing: Text(
                                      review.date,
                                      style: const TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey),
                                    ),
                                  ),
                                ),
                              )
                                  .toList() ??
                                  [const Text('Belum ada ulasan')],
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