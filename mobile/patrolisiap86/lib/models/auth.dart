import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:mobilepatrol/general/session.dart';

class Mod_Auth {
  session? sess;
  Map? Parameter;

  Mod_Auth(this.sess, {this.Parameter});

  Future<Map> Register() async{
    var url = Uri.parse(sess!.server+"auth/register");
    final response = await http.post(url,body: this.Parameter);
    return json.decode(response.body);
  }

  Future<Map> Login() async{
    var url = Uri.parse(sess!.server+"APILogin");
    final response = await http.post(url,body: this.Parameter);
    print(this.Parameter);
    print(response.body.toString());
    return json.decode(response.body);
  }

  Future<Map> getMenu() async{
    var url = Uri.parse(sess!.server+"auth/menudata");
    final response = await http.post(url,body: this.Parameter);
    return json.decode(response.body);
  }

  Future<Map> readUser() async{
    var url = Uri.parse(sess!.server+"auth/readuser");
    final response = await http.post(url,body: this.Parameter);
    return json.decode(response.body);
  }

  Future<Map> addUser() async{
    var url = Uri.parse(sess!.server+"auth/adduser");
    final response = await http.post(url,body: this.Parameter);
    return json.decode(response.body);
  }

  Future<Map> UpdateToken() async{
    print(this.Parameter);
    var url = Uri.parse(sess!.server+"APIUpdateToken");
    final response = await http.post(url,body: this.Parameter);
    return json.decode(response.body);
  }

  Future<Map> getPaymentMethod() async{
    var url = Uri.parse(sess!.server+"APIGetPayment");
    final response = await http.post(url,body: this.Parameter);
    return json.decode(response.body);
  }

  Future<Map> TestASPNet() async{
    var url = Uri.parse("http://192.168.1.66:51265/api/Account/Register");
    final response = await http.post(url,body: this.Parameter);
    return json.decode(response.body);
  }
}
