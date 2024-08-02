import 'package:flutter/material.dart';

class SnackBarTheme {
  static void showSnackBar(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          text,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
        ),
        backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(milliseconds: 2000),
        
      ),
    );
  }
}