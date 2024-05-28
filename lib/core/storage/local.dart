import 'package:hive/hive.dart';

class LocaleService {
  static const String LocaleKey = 'locale';
  static const String Is_opened = 'Is_Opened';

  // set
  static cacheData(String key, dynamic value) async {
    var box = Hive.box('local');
    box.put(key, value);
  }

  //get
  static Future<dynamic> getCachedData(String key) async {
    var box = Hive.box('local');
    return box.get(key);
  }
}
