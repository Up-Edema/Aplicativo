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

class AuthValidatorItem extends StatelessWidget {
  const AuthValidatorItem({
    super.key,
    required this.label,
    required this.valid,
  });

  final String label;
  final bool valid;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          valid ? Iconsax.tick_circle : Iconsax.close_circle,
          color: valid
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.error,
          size: 18,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            label,
            style: Theme.of(context).textTheme.bodySmall,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
