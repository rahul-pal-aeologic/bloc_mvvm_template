import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class LoggerHelper {
  static var logger = Logger();

  static printLogValue(dynamic message,
      [dynamic error, StackTrace? stackTrace]) {
    logger.d(message, error: error, stackTrace: stackTrace);
  }

  static printWrapped(String text) {
    final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
    pattern.allMatches(text).forEach((match) => debugPrint(match.group(0)));
  }

  static printError(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    logger.e(message, error: error, stackTrace: stackTrace);
  }

  static String titleCase(String? inputText) {
    String text = inputText ?? "";
    try {
      text = text.replaceAll("  ", ' ');
      if (text.trim().isNotEmpty) {
        text = text.trim();
        if (text.length <= 1) return text.toUpperCase();
        var words = text.split(' ');
        if (words.isNotEmpty) {
          var capitalized = words.map((word) {
            var first = word.substring(0, 1).toUpperCase();
            var rest = word.substring(1);
            return '$first$rest';
          });
          return capitalized.join(' ');
        } else {
          return "";
        }
      } else {
        return "";
      }
    } catch (error) {
      debugPrint("Error: $error");
      return "";
    }
  }
}
