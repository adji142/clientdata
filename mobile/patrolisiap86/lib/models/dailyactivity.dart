import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:mobilepatrol/general/session.dart';

class Mod_DailyActivity {
  session? sess;
  Map? Parameter;

  Mod_DailyActivity(this.sess, {this.Parameter});

  Future<Map> Read() async {
    var url = Uri.parse(sess!.server + "APIDailyActivity");
    final response = await http.post(url, body: this.Parameter);
    // print(this.Parameter);
    return json.decode(response.body);
  }

  Future<Map> Find() async {
    var url = Uri.parse(sess!.server + "APIFindDailyActivity");
    final response = await http.post(url, body: this.Parameter);
    // print(this.Parameter);
    return json.decode(response.body);
  }

  Future<Map> Append() async {
    var url = Uri.parse(sess!.server + "APICRUDDailyActivity");
    final response = await http.post(url, body: this.Parameter);
    print(this.Parameter!["Gambar1"]);
    print(response.body.toString());
    return json.decode(response.body);
  }
}