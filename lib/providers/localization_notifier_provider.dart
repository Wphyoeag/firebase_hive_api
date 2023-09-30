import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final localizationChangeNotifierProvider =
    ChangeNotifierProvider((ref) => LocalizeNotifier());

class LocalizeNotifier extends ChangeNotifier {
  Locale _current = const Locale('vi');
  Locale get currnet => _current;
  changeLocale(Locale l) {
    _current = l;
    notifyListeners();
  }
}
