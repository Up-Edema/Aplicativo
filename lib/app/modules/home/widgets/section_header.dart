import 'package:flutter/material.dart';

class SectionHeader extends StatelessWidget {
  const SectionHeader({super.key, required this.title, required this.onSeeAll});
  final String title;
  final VoidCallback onSeeAll;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final textTheme = Theme.of(context).textTheme;

    final TextStyle baseStyle = width < 360
        ? (textTheme.titleSmall ??
              const TextStyle(fontSize: 16, fontWeight: FontWeight.w700))
        : (width < 600
              ? (textTheme.titleMedium ??
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w700))
              : (textTheme.titleLarge ??
                    const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    )));
    final TextStyle titleStyle = baseStyle.copyWith(
      fontWeight: FontWeight.bold,
      color: Colors.black,
    );

    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 8),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: titleStyle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          TextButton(
            style: TextButton.styleFrom(
              minimumSize: const Size(0, 0),
              padding: const EdgeInsets.symmetric(horizontal: 8),
              textStyle: textTheme.bodyMedium?.copyWith(fontSize: 13),
            ),
            onPressed: onSeeAll,
            child: const Text('Ver tudo'),
          ),
        ],
      ),
    );
  }
}
