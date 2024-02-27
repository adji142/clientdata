import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:mobilepatrol/general/session.dart';

class Mod_GuestLog {
  session? sess;
  Map? Parameter;

  Mod_GuestLog(this.sess, {this.Parameter});

  Future<Map> ReadGuestLog() async {
    var url = Uri.parse(sess!.server + "APIGuestLog");
    final response = await http.post(url, body: this.Parameter);
    // print(this.Parameter);
    return json.decode(response.body);
  }

  Future<Map> FindGuestLog() async {
    var url = Uri.parse(sess!.server + "APIFindGuestLog");
    final response = await http.post(url, body: this.Parameter);
    // print(this.Parameter);
    return json.decode(response.body);
  }

  Future<Map> AppendGuestLog() async {
    var url = Uri.parse(sess!.server + "APICRUDGuestLog");
    final response = await http.post(url, body: this.Parameter);
    // print(this.Parameter);
    print(response.body.toString());
    return json.decode(response.body);
  }
}