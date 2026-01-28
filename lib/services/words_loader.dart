import 'dart:convert';

import 'package:flutter/services.dart';

class WordsLoader {
  static Future<List<String>> loadWords(String localeCode) async {
    final jsonString =
        await rootBundle.loadString('assets/words/$localeCode.json');
    final List<dynamic> decoded = jsonDecode(jsonString);
    return decoded.cast<String>();
  }
}
