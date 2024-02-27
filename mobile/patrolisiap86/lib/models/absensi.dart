import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:mobilepatrol/general/session.dart';

class Mod_Absensi {
  session? sess;
  Map? Parameter;

  Mod_Absensi(this.sess, this.Parameter);

  Future<Map> Read() async{
    var url = Uri.parse(sess!.server+"APIAttRead");
    final response = await http.post(url,body: this.Parameter);
    print(this.Parameter);
    return json.decode(response.body);
  }

  Future<Map> Create() async{
    var url = Uri.parse(sess!.server+"APIAttCRUD");
    final response = await http.post(url,body: this.Parameter);
    print(this.Parameter);
    return json.decode(response.body);
  }
}
