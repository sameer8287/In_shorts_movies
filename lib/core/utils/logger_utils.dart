import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

/// Application-wide logging utility class
///
/// This class provides centralized logging functionality with different log levels
/// and device information gathering capabilities. It uses the Logger package for
/// enhanced logging features and only outputs logs in debug mode for security.
///
/// Features:
/// - Multiple log levels (error, debug, info)
/// - Debug-mode only logging for production safety
/// - Device information collection for debugging
/// - Consistent logging format across the app
///
/// Usage:
/// ```dart
/// AppLogger.d('Debug message');
/// AppLogger.i('Info message');
/// AppLogger.e('Error message');
///
/// // Get device info for debugging
/// var deviceData = await AppLogger.deviceInfo();
/// ```
class AppLogger {
  /// Static instance of the Logger for consistent logging behavior across the app
  ///
  /// Uses default Logger configuration with pretty printing for better readability
  /// in development environment
  static final Logger appLogger = Logger();

  /// Retrieves device information for debugging purposes
  ///
  /// This method collects comprehensive device information including:
  /// - Device model and manufacturer
  /// - Operating system version
  /// - Hardware specifications
  /// - Platform-specific details
  ///
  /// Returns a Map containing all available device information
  ///
  /// Example:
  /// ```dart
  /// Map<String, dynamic> deviceData = await AppLogger.deviceInfo();
  /// AppLogger.d('Running on: ${deviceData['model']}');
  /// ```
  ///
  /// Use cases:
  /// - Crash reporting with device context
  /// - Feature compatibility checking
  /// - Performance analysis per device type
  /// - User support diagnostics
  // static Future<dynamic> deviceInfo() async {
  //   final deviceInfoPlugin = DeviceInfoPlugin();
  //   final deviceInfo = await deviceInfoPlugin.deviceInfo;
  //   return deviceInfo.data;
  // }

  /// Logs error messages
  ///
  /// Use this method for logging errors, exceptions, and critical issues.
  /// Only outputs in debug mode to prevent sensitive information leakage in production.
  ///
  /// [e] - The error message or exception to log
  ///
  /// Example:
  /// ```dart
  /// try {
  ///   // Some operation that might fail
  /// } catch (error) {
  ///   AppLogger.e('Failed to process data: $error');
  /// }
  /// ```
  ///
  /// Best practices:
  /// - Include context about what operation failed
  /// - Log stack traces for exceptions
  /// - Don't log sensitive user data
  static void e(String e) {
    if (kDebugMode) {
      appLogger.e(e);
    }
  }

  /// Logs debug messages
  ///
  /// Use this method for detailed debugging information during development.
  /// Only outputs in debug mode and should be used liberally during development.
  ///
  /// [d] - The debug message to log
  ///
  /// Example:
  /// ```dart
  /// AppLogger.d('User tapped login button');
  /// AppLogger.d('API response: $responseData');
  /// AppLogger.d('Navigation state: $currentRoute');
  /// ```
  ///
  /// Best practices:
  /// - Include variable values and state information
  /// - Log method entry/exit points for complex flows
  /// - Add timestamps for performance analysis
  static void d(String d) {
    if (kDebugMode) {
      appLogger.d(d);
    }
  }

  /// Logs informational messages
  ///
  /// Use this method for general information, successful operations,
  /// and important application state changes.
  /// Only outputs in debug mode for production safety.
  ///
  /// [i] - The informational message to log
  ///
  /// Example:
  /// ```dart
  /// AppLogger.i('User logged in successfully');
  /// AppLogger.i('Data sync completed');
  /// AppLogger.i('App started in ${kDebugMode ? 'debug' : 'release'} mode');
  /// ```
  ///
  /// Best practices:
  /// - Log successful completion of important operations
  /// - Record configuration and initialization status
  /// - Track user journey milestones
  static void i(String i) {
    if (kDebugMode) {
      appLogger.i(i);
    }
  }
}
