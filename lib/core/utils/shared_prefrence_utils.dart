import 'package:shared_preferences/shared_preferences.dart';

/// Utility class for managing SharedPreferences operations
///
/// This class provides a singleton-based approach to handle local data storage
/// using SharedPreferences. It supports storing and retrieving String, int, and bool values.
///
/// Usage:
/// ```dart
/// // Initialize in main() function
/// await SharedPrefUtils.init();
///
/// // Store values
/// await SharedPrefUtils.setValue('username', 'john_doe');
/// await SharedPrefUtils.setValue('user_age', 25, isInt: true);
/// await SharedPrefUtils.setValue('is_logged_in', true, isBool: true);
///
/// // Retrieve values
/// String username = SharedPrefUtils.getValue('username', defValue: '');
/// int age = SharedPrefUtils.getValue('user_age', isInt: true, defValue: 0);
/// bool isLoggedIn = SharedPrefUtils.getValue('is_logged_in', isBool: true, defValue: false);
/// ```
class SharedPrefUtils {
  /// Singleton instance of SharedPreferences
  /// Uses lazy initialization to create instance only when needed
  static Future<SharedPreferences> get _instance async => _prefsInstance ??= await SharedPreferences.getInstance();
  static SharedPreferences? _prefsInstance;

  /// Initialize the SharedPreferences instance
  ///
  /// Call this method from initState() function of mainApp() or in main() function
  /// to ensure SharedPreferences is ready before use.
  ///
  /// Returns the initialized SharedPreferences instance
  ///
  /// Example:
  /// ```dart
  /// void main() async {
  ///   WidgetsFlutterBinding.ensureInitialized();
  ///   await SharedPrefUtils.init();
  ///   runApp(MyApp());
  /// }
  /// ```
  static Future<SharedPreferences> init() async {
    _prefsInstance = await _instance;
    return _prefsInstance ?? await SharedPreferences.getInstance();
  }

  /// Get value from SharedPreferences with type safety
  ///
  /// [key] - The key to retrieve value for
  /// [defValue] - Default value to return if key doesn't exist
  /// [isInt] - Set true if expecting integer value
  /// [isBool] - Set true if expecting boolean value
  ///
  /// Returns the stored value or default value with proper type casting
  ///
  /// Example:
  /// ```dart
  /// String name = SharedPrefUtils.getValue('user_name', defValue: 'Unknown');
  /// int count = SharedPrefUtils.getValue('item_count', isInt: true, defValue: 0);
  /// bool enabled = SharedPrefUtils.getValue('notifications', isBool: true, defValue: true);
  /// ```
  static dynamic getValue(String key, {dynamic defValue, bool isInt = false, bool isBool = false}) {
    if (isBool) return _prefsInstance?.getBool(key) ?? defValue ?? false;
    if (isInt) return _prefsInstance?.getInt(key) ?? defValue ?? 0;
    return _prefsInstance?.getString(key) ?? defValue ?? "";
  }

  /// Get String value from SharedPreferences
  ///
  /// [key] - The key to retrieve value for
  /// [defValue] - Default value to return if key doesn't exist
  ///
  /// Returns the stored string value or default value
  ///
  /// This is a convenience method specifically for string values
  static String? getStringValue(String key, {String? defValue}) {
    return _prefsInstance?.getString(key) ?? defValue;
  }

  /// Set value in SharedPreferences with type safety
  ///
  /// [key] - The key to store value under
  /// [value] - The value to store
  /// [isInt] - Set true if storing integer value
  /// [isBool] - Set true if storing boolean value
  ///
  /// Returns Future<bool> indicating whether the operation was successful
  ///
  /// Example:
  /// ```dart
  /// await SharedPrefUtils.setValue('username', 'john_doe');
  /// await SharedPrefUtils.setValue('age', 25, isInt: true);
  /// await SharedPrefUtils.setValue('is_active', true, isBool: true);
  /// ```
  static Future<bool> setValue(String key, dynamic value, {bool isInt = false, bool isBool = false}) async {
    var prefs = await _instance;
    if (isBool) return await _prefsInstance?.setBool(key, value) ?? false;
    if (isInt) return await _prefsInstance?.setInt(key, value) ?? false;
    return prefs.setString(key, value);
  }

  /// Clear all values in SharedPreferences
  ///
  /// This will remove all stored key-value pairs.
  /// Use with caution as this cannot be undone.
  ///
  /// Returns Future<bool> indicating whether the operation was successful
  ///
  /// Example:
  /// ```dart
  /// bool success = await SharedPrefUtils.clear();
  /// if (success) {
  ///   print('All preferences cleared successfully');
  /// }
  /// ```
  static Future<bool> clear() async {
    return (await _prefsInstance?.clear()) ?? true;
  }

  /// Write value to SharedPreferences (instance method)
  ///
  /// This is an instance method that automatically detects the value type
  /// and stores it with the appropriate SharedPreferences method.
  ///
  /// [key] - The key to store value under
  /// [value] - The value to store (String, int, or bool)
  ///
  /// Example:
  /// ```dart
  /// SharedPrefUtils utils = SharedPrefUtils();
  /// utils.write('score', 100);        // Stores as int
  /// utils.write('name', 'John');      // Stores as String
  /// utils.write('enabled', true);     // Stores as bool
  /// ```
  void write(String key, value) async {
    _prefsInstance ??= await _instance;
    if (value is int) {
      await _prefsInstance?.setInt(key, value);
    } else if (value is bool) {
      await _prefsInstance?.setBool(key, value);
    } else {
      await _prefsInstance?.setString(key, value);
    }
  }

  /// Read value from SharedPreferences with type specification
  ///
  /// [key] - The key to retrieve value for
  /// [isInt] - Set true if expecting integer value
  /// [isBool] - Set true if expecting boolean value
  ///
  /// Returns the stored value with proper type or default value for the type
  ///
  /// Example:
  /// ```dart
  /// String name = await SharedPrefUtils.read('username');
  /// int count = await SharedPrefUtils.read('count', isInt: true);
  /// bool status = await SharedPrefUtils.read('status', isBool: true);
  /// ```
  static Future<dynamic> read(String key, {bool isInt = false, bool isBool = false}) async {
    final prefs = await _instance;
    if (isInt) return prefs.getInt(key) ?? 0;
    if (isBool) return prefs.getBool(key) ?? false;
    return prefs.getString(key) ?? "";
  }

  /// Clear all values in SharedPreferences (instance method)
  ///
  /// This is an instance method version of the clear functionality.
  /// Creates a new SharedPreferences instance and clears all data.
  ///
  /// Returns Future<bool> indicating whether the operation was successful
  Future<bool> clearPref() async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.clear();
  }

  /// Delete a specific key from SharedPreferences
  ///
  /// [key] - The key to remove from storage
  ///
  /// Returns Future<bool> indicating whether the operation was successful
  ///
  /// Example:
  /// ```dart
  /// bool removed = await SharedPrefUtils.deleteKey('temp_data');
  /// if (removed) {
  ///   print('Temporary data removed successfully');
  /// }
  /// ```
  static Future<bool> deleteKey(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.remove(key);
  }
}
