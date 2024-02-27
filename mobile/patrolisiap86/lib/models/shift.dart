import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:mobilepatrol/general/session.dart';

class Mod_Shift {
  session? sess;
  Map? Parameter;

  Mod_Shift(this.sess, this.Parameter);

  Future<Map> getShift() async {
    var url = Uri.parse(sess!.server + "APIShiftRead");
    final response = await http.post(url, body: this.Parameter);
    // print(this.Parameter);
    return json.decode(response.body);
  }

  Future<Map> getJadwal() async {
    var url = Uri.parse(sess!.server + "APIGetJadwal");
    final response = await http.post(url, body: this.Parameter);
    // print(this.Parameter);
    return json.decode(response.body);
  }
}
