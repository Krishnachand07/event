import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ServiceRepository {
  Future<Map<String, dynamic>> getEvents() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      final data = preferences.getString("data");
      if (data == null) {
        final response = await http.get(
          Uri.https("mock.apidog.com", "/m1/561191-524377-default/Event"),
        );
        if (response.statusCode == 200) {
          await preferences.setString("data", response.body);
          final jsonData = json.decode(response.body);
          return jsonData;
        }
        return {"message": "Something went wrong!"};
      } else {
        final jsonData = json.decode(data);
        return jsonData;
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
