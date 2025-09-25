import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:gowaroenk/provider/detail/expendable_text_provider.dart';

class ExpandableTextWidget extends StatelessWidget {
  final String text;
  final int maxLines;

  const ExpandableTextWidget({
    super.key,
    required this.text,
    this.maxLines = 4,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ExpandableTextProvider(),
      child: Consumer<ExpandableTextProvider>(
        builder: (context, provider, child) {
          final textStyle = Theme.of(context).textTheme.bodyMedium;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                text,
                textAlign: TextAlign.justify,
                style: textStyle,
                maxLines: provider.expanded ? null : maxLines,
                overflow: provider.expanded ? TextOverflow.visible : TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              InkWell(
                onTap: provider.toggle,
                child: Text(
                  provider.expanded ? "Read less" : "Read more",
                  style: textStyle?.copyWith(
                    fontSize: 12,
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
