import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

final themeProvider = StateNotifierProvider<ThemeNotifier, bool>((ref) {
  return ThemeNotifier();
});

class ThemeNotifier extends StateNotifier<bool> {
  ThemeNotifier() : super(false) {
    _loadTheme();
  }

  void _loadTheme() async {
    final box = await Hive.openBox('settings');
    state = box.get('isDarkMode', defaultValue: false);
  }

  void toggleTheme() async {
    state = !state;
    final box = await Hive.openBox('settings');
    box.put('isDarkMode', state);
  }
}
