import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:mobilepatrol/general/session.dart';

class Mod_SOS {
  session? sess;
  Map? Parameter;

  Mod_SOS(this.sess, this.Parameter);

  Future<Map> create() async {
    var url = Uri.parse(sess!.server + "APISOSCreate");
    final response = await http.post(url, body: this.Parameter);
    return json.decode(response.body);
  }
  Future<Map> read() async {
    var url = Uri.parse(sess!.server + "APISOSRead");
    final response = await http.post(url, body: this.Parameter);
    return json.decode(response.body);
  }
}
