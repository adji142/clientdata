import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:mobilepatrol/general/session.dart';

class Mod_CompanyDetails {
  session? sess;
  Map? Parameter;
  Mod_CompanyDetails(this.sess, this.Parameter);

  Future<Map> Read() async{
    var url = Uri.parse(sess!.server+"APIAttRead");
    final response = await http.post(url,body: this.Parameter);
    return json.decode(response.body);
  }
}