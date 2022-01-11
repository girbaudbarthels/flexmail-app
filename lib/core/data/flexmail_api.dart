import 'dart:convert';

import 'package:flexmail_app/core/data/local_storage.dart';
import 'package:http/http.dart' as http;

enum LoginStatus {
  loggedIn,
  rejected,
}

class FlexmailApi {
  static Future<LoginStatus> getLoginStatus(
      String username, String accesToken) async {
    final basicAuth =
        'Basic ${base64Encode(utf8.encode('$username:$accesToken'))}';
    final response = await http.get(
      Uri.parse('https://api.flexmail.eu'),
      headers: <String, String>{
        'Accept': 'application/hal+json',
        'Authorization': basicAuth
      },
    );

    if (response.statusCode == 200) {
      await LocalData.setAuth(basicAuth);
      return LoginStatus.loggedIn;
    } else {
      return LoginStatus.rejected;
    }
  }

  static Future<LoginStatus> onInitApp() async {
    final basicAuth = await LocalData.getAuth();
    final response = await http.get(
      Uri.parse('https://api.flexmail.eu'),
      headers: <String, String>{
        'Accept': 'application/hal+json',
        'Authorization': basicAuth
      },
    );

    if (response.statusCode == 200) {
      return LoginStatus.loggedIn;
    } else {
      return LoginStatus.rejected;
    }
  }

  Future<Map<String, dynamic>> getContacts() async {
    final basicAuth = await LocalData.getAuth();

    final response = await http.get(
      Uri.parse('https://api.flexmail.eu/contacts?limit=20'),
      headers: <String, String>{
        'Accept': 'application/hal+json',
        'Authorization': basicAuth
      },
    );
    final contactList = jsonDecode(response.body) as Map<String, dynamic>;
    return contactList;
  }
}
