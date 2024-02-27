import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:mobilepatrol/general/session.dart';

class Mod_Patroli {
  session? sess;
  Map? Parameter;

  Mod_Patroli(this.sess, {this.Parameter});

  Future<Map> getPatroliList() async {
    var url = Uri.parse(sess!.server + "APIReadPatroli");
    final response = await http.post(url, body: this.Parameter);
    print(this.Parameter);
    return json.decode(response.body);
  }

  Future<Map> save() async {
    var url = Uri.parse(sess!.server + "APIAddPatroli");
    final response = await http.post(url, body: this.Parameter);
    print(Parameter);
    return json.decode(response.body);
  }

  Future<Map> readLokasi() async {
    var url = Uri.parse(sess!.server + "C_LokasiPatroli/Read");
    final response = await http.post(url, body: this.Parameter);
    // print(Parameter);
    return json.decode(response.body);
  }
}
