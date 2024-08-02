import 'package:flutter/material.dart';

class TextFormField {
  static InputDecoration inputDecoration(
      BuildContext context, String labelText) {
    return InputDecoration(
      alignLabelWithHint: true,
      labelText: labelText,
      labelStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
            color: Theme.of(context).colorScheme.primary,
          ),
      errorStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
            color: Theme.of(context).colorScheme.error,
          ),
      contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      filled: true,
      fillColor: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3),
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).colorScheme.primary)),
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).colorScheme.primary)),
      errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).colorScheme.error)),
      focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).colorScheme.error)),
    );
      }
}