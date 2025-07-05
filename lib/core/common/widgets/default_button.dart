import 'package:flutter/material.dart';

class DefaultButton extends StatelessWidget {
  final String? title;
  final Color? backgroundColor;
  final Color? textColor;
  final Function()? onPressed;
  final EdgeInsets? padding;

  const DefaultButton({
    super.key,
    this.title,
    this.backgroundColor,
    this.textColor,
    this.onPressed,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: ElevatedButton(
        onPressed: onPressed,
        style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
          backgroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.disabled)) {
              return backgroundColor?.withValues(alpha: 0.5);
            } else {
              return backgroundColor;
            }
          }),
          foregroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.disabled)) {
              return textColor?.withValues(alpha: 0.5);
            } else {
              return textColor;
            }
          }),
        ),
        child: Text(title ?? ''),
      ),
    );
  }
}
