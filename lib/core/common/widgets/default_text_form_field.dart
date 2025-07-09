import 'package:flutter/material.dart';

class DefaultTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final String? prefixText;
  final String? initialValue;
  final TextInputType? keyboardType;
  final Function(String)? onChanged;
  final Widget? prefixIcon;
  final int? maxLines;
  final int? maxLength;
  final int? minLines;

  const DefaultTextFormField({
    super.key,
    this.controller,
    this.hintText,
    this.prefixText,
    this.initialValue,
    this.keyboardType,
    this.onChanged,
    this.prefixIcon,
    this.maxLines,
    this.maxLength,
    this.minLines,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      initialValue: initialValue,
      keyboardType: keyboardType,
      maxLines: maxLines,
      minLines: minLines,
      maxLength: maxLength,
      style: Theme.of(context).textTheme.bodyMedium,
      decoration: InputDecoration(
        filled: true,
        fillColor: Theme.of(context).colorScheme.surface,
        prefixText: prefixText,
        prefixIcon: prefixIcon,
        hintText: hintText,
        hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: Theme.of(context).colorScheme.onSurface.withValues(alpha: .7),
        ),
        counterStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
          color: Theme.of(context).colorScheme.onSurface,
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
      onChanged: onChanged,
    );
  }
}
