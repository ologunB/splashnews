import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

const String kUserBoxName = 'useirBox';
const String kSavedBox = 'saved';
const String kRecentBox = 'recent';

class AppCache {
  static Future<void> init() async {
    await Hive.initFlutter();
    await Hive.openBox<List<dynamic>>(kUserBoxName);
  }

  static Box<List<dynamic>> get _box => Hive.box<List<dynamic>>(kUserBoxName);

  void nothing() {}

  static void saveJsonData({@required Map<String, dynamic> article}) {
    if (article == null) {
      return;
    }

    final List<dynamic> list = getSavedData().toSet().toList();

    list.add(article);

    _box.put(kSavedBox, list);
  }

  static void clear() {
    _box.clear();
  }

  static void clean(String key) {
    _box.delete(key);
  }

  static List<dynamic> getSavedData() {
    final List<dynamic> data = _box.get(kSavedBox, defaultValue: <dynamic>[]);
    if (data == null) {
      return <Map<String, dynamic>>[];
    }
    final List<dynamic> list = List<dynamic>.from(data);
    return list;
  }
}
