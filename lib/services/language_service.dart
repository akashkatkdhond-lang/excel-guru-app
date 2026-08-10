import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Supported content languages. Keep codes short — they're used as the
/// SharedPreferences value and as switch keys in the data layer.
class AppLanguage {
  static const hinglish = 'hi';
  static const marathi = 'mr';
}

/// Tracks which language the lesson/quiz CONTENT is shown in. Navigation
/// chrome (button labels, screen titles) stays as-is — only educational
/// content (lessons, quiz questions) switches, since that's where the
/// real learning value is.
class LanguageService extends ChangeNotifier {
  static const _key = 'app_language';

  SharedPreferences? _prefs;
  String _language = AppLanguage.hinglish;

  String get language => _language;
  bool get isMarathi => _language == AppLanguage.marathi;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    _language = _prefs?.getString(_key) ?? AppLanguage.hinglish;
    notifyListeners();
  }

  Future<void> setLanguage(String language) async {
    _language = language;
    await _prefs?.setString(_key, language);
    notifyListeners();
  }
}
