import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:mobilepatrol/general/session.dart';

class Mod_Payment {
  session? sess;

  Mod_Payment(this.sess);

  Future<Map> getLookup(Map Parameter) async {
    var url = Uri.parse(sess!.server+"APIGetLookupPayment");
    final response = await http.post(url,body: Parameter);
    return json.decode(response.body);
  }
}
