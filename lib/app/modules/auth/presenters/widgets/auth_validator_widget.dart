import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:up_edema/app/utils/app_theme.dart';

class ValidationCriteria extends StatelessWidget {
  const ValidationCriteria({
    Key? key,
    required this.text,
    required this.isValid,
  }) : super(key: key);

  final String text;
  final bool isValid;

  @override
  Widget build(BuildContext context) {
    final activeColor = AppColors.primary;
    final inactiveColor = AppColors.secondaryText;

    return Padding(
      padding: const EdgeInsets.only(bottom: 6.0),
      child: Row(
        children: [
          Icon(
            isValid
                ? Iconsax.tick_circle_copy
                : Iconsax.close_circle_copy,
            size: 20,
            color: isValid
                ? activeColor
                : inactiveColor,
          ),
          const SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(
              color: isValid
                  ? activeColor
                  : inactiveColor,
              decoration: isValid
                  ? TextDecoration.lineThrough
                  : null,
            ),
          ),
        ],
      ),
    );
  }
}
