import 'package:localstorage/localstorage.dart';

class LocalData {
  static final storage = LocalStorage('flexmail_data');

  static Future<String> getAuth() async {
    await storage.ready;
    try {
      final basicAuth = storage.getItem('basicAuth').toString();
      return basicAuth;
    } catch (e) {
      return '';
    }
  }

  static Future<void> setAuth(String basicAuth) async {
    try {
      await storage.setItem('basicAuth', basicAuth);
    } catch (e) {
      print(e);
    }
  }
}
