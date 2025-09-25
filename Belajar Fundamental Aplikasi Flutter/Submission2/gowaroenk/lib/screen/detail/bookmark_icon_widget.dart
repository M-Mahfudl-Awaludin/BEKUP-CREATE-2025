import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:gowaroenk/data/model/restaurant.dart';
import 'package:gowaroenk/provider/detail/bookmark_icon_provider.dart';
import 'package:gowaroenk/provider/bookmark/local_database_provider.dart';

class BookmarkIconWidget extends StatefulWidget {
  final Restaurant restaurant;

  const BookmarkIconWidget({
    super.key,
    required this.restaurant,
  });

  @override
  State<BookmarkIconWidget> createState() => _BookmarkIconWidgetState();
}

class _BookmarkIconWidgetState extends State<BookmarkIconWidget> {
  @override
  void initState() {
    super.initState();

    final dbProvider = Provider.of<LocalDatabaseProvider>(context, listen: false);
    final iconProvider = Provider.of<BookmarkIconProvider>(context, listen: false);

    Future.microtask(() async {
      final isBookmarked = await dbProvider.isFavorite(widget.restaurant.id);

      if (mounted) {
        iconProvider.isBookmarked = isBookmarked;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async {
        final dbProvider = context.read<LocalDatabaseProvider>();
        final iconProvider = context.read<BookmarkIconProvider>();
        final isBookmarked = iconProvider.isBookmarked;

        if (isBookmarked) {
          await dbProvider.removeFavorite(widget.restaurant.id);
        } else {
          await dbProvider.addFavorite(widget.restaurant);
        }

        iconProvider.isBookmarked = !isBookmarked;
      },
      icon: Icon(
        context.watch<BookmarkIconProvider>().isBookmarked
            ? Icons.bookmark
            : Icons.bookmark_outline,
      ),
    );
  }
}
