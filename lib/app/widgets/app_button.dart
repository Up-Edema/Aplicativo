import 'package:flutter/material.dart';
import 'package:up_edema/app/utils/app_theme.dart';

class _ButtonChild extends StatelessWidget {
  const _ButtonChild({
    required this.text,
    required this.isLoading,
    required this.textColor,
  });

  final String text;
  final bool isLoading;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return SizedBox(
        width: 24,
        height: 24,
        child: CircularProgressIndicator(
          color: textColor,
          strokeWidth: 2.5,
        ),
      );
    }
    return Text(text);
  }
}

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.borderRadius,
  });

  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final double? borderRadius;

  @override
  Widget build(BuildContext context) {
    final ButtonStyle? themeStyle = Theme.of(
      context,
    ).filledButtonTheme.style;
    ButtonStyle? finalStyle;
    if (borderRadius != null) {
      finalStyle = themeStyle?.copyWith(
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              borderRadius!,
            ),
          ),
        ),
      );
    } else {
      finalStyle = themeStyle;
    }

    return SizedBox(
      width: double.infinity,
      child: FilledButton(
        style: finalStyle,
        onPressed: isLoading ? null : onPressed,
        child: _ButtonChild(
          text: text,
          isLoading: isLoading,
          textColor: Theme.of(
            context,
          ).colorScheme.onPrimary,
        ),
      ),
    );
  }
}

class SecondaryButton extends StatelessWidget {
  const SecondaryButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.padding,
  });

  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    final ButtonStyle? themeStyle = Theme.of(
      context,
    ).textButtonTheme.style;
    final ButtonStyle? finalStyle =
        padding != null
        ? themeStyle?.copyWith(
            padding: WidgetStateProperty.all(
              padding,
            ),
          )
        : themeStyle;

    return TextButton(
      style: finalStyle,
      onPressed: isLoading ? null : onPressed,
      child: _ButtonChild(
        text: text,
        isLoading: isLoading,
        textColor: Theme.of(
          context,
        ).colorScheme.primary, // Teal
      ),
    );
  }
}

// ...

class OutlinedPrimaryButton
    extends StatelessWidget {
  const OutlinedPrimaryButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
  });

  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: isLoading ? null : onPressed,
        child: _ButtonChild(
          text: text,
          isLoading: isLoading,
          textColor: Theme.of(
            context,
          ).colorScheme.primary,
        ),
      ),
    );
  }
}

class DestructiveButton extends StatelessWidget {
  const DestructiveButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
  });

  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(
      context,
    ).filledButtonTheme.style;
    final style = theme?.copyWith(
      backgroundColor: WidgetStateProperty.all(
        AppColors.destructive,
      ),
    );

    return SizedBox(
      width: double.infinity,
      child: FilledButton(
        style: style,
        onPressed: isLoading ? null : onPressed,
        child: _ButtonChild(
          text: text,
          isLoading: isLoading,
          textColor: Theme.of(
            context,
          ).colorScheme.onPrimary,
        ),
      ),
    );
  }
}
