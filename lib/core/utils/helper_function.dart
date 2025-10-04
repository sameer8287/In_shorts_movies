import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import '../l10n/generated/l10n.dart';
import 'logger_utils.dart';

/// A collection of utility functions used throughout the application
///
/// This class provides various helper methods for:
/// - Logging and debugging
/// - String manipulation and masking
/// - Date and time formatting
/// - Age calculations
/// - Form status handling
/// - Content parsing and widget generation
/// - User interface helpers
class HelperFunctions {
  /// Prints debug logs only in debug mode
  ///
  /// [tag] - A label to identify the log source
  /// [message] - The message or data to log
  ///
  /// Usage:
  /// ```dart
  /// HelperFunctions.printLog('LoginScreen', 'User logged in successfully');
  /// ```
  static void printLog(String tag, dynamic message) {
    if (kDebugMode) {
      AppLogger.d("$tag: $message");
    }
  }

  /// Shows a simple snackbar message
  ///
  /// [context] - The build context
  /// [text] - The message to display
  /// [color] - Optional background color (defaults to black)
  ///
  /// Note: Consider using SnackbarUtil for more advanced snackbar features
  static void showSnackBar(BuildContext context, String text, {Color? color = Colors.black}) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text), backgroundColor: color));
  }

  static String formatCurrency(int amount) {
    if (amount >= 1000000000) {
      return "${(amount / 1000000000).toStringAsFixed(1)}B";
    } else if (amount >= 1000000) {
      return "${(amount / 1000000).toStringAsFixed(1)}M";
    } else if (amount >= 1000) {
      return "${(amount / 1000).toStringAsFixed(1)}K";
    }
    return amount.toString();
  }
}

extension Unique<E, Id> on List<E> {
  List<E> unique([Id Function(E element)? id, bool inplace = true]) {
    final Set<dynamic> ids = <dynamic>{};
    var list = inplace ? this : List<E>.from(this);
    list.retainWhere((x) => ids.add(id != null ? id(x) : x as Id));
    return list;
  }
}

extension LocalizationExtension on BuildContext {
  S get l10n => S.of(this);
}
