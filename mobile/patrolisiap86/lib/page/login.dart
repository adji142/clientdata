import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:mobilepatrol/general/dialog.dart';
import 'package:mobilepatrol/general/session.dart';
import 'package:mobilepatrol/models/auth.dart';
import 'package:mobilepatrol/models/patroli.dart';
import 'package:mobilepatrol/page/dashboard.dart';
import 'package:mobilepatrol/page/register.dart';
import 'package:mobilepatrol/shared/sharedprefrence.dart';

class LoginMobilePotrait extends StatefulWidget {
  final session? sess;
  LoginMobilePotrait(this.sess);

  @override
  _LoginMobilePotraitState createState() => _LoginMobilePotraitState();
}

class _LoginMobilePotraitState extends State<LoginMobilePotrait> {
  TextEditingController _Server = TextEditingController();
  TextEditingController _PartnerCode = TextEditingController();
  TextEditingController _UserName = TextEditingController();
  TextEditingController _Password = TextEditingController();
  FocusNode _serverNode = FocusNode();

  final GlobalKey<State> _keyLoader = new GlobalKey<State>();

  bool _obscured = false;
  bool _isReadonly = false;
  bool _isReadonlyServer = false;

  @override
  void initState() {
    // _Server.text = "http://patroli.aissystem.org/";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // print(this.widget.sess!.server);
    return Scaffold(
      body: ListView(
        // mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.only(
                left: this.widget.sess!.hight * 5,
              ),
              child: Image.asset(
                "assets/newlogo.png",
                width: this.widget.sess!.width * 80,
                height: this.widget.sess!.hight * 35,
              ),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.only(left: this.widget.sess!.hight * 5),
              child: Text(
                "Masuk Sebagai",
                style: TextStyle(
                  fontFamily: "Montserrat",
                  fontSize: this.widget.sess!.hight * 3,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF000031)
                ),
                textAlign: TextAlign.left,
              ),
            ),
          ),
          Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.only(left: this.widget.sess!.hight * 5),
                child: Text(
                  "Member",
                  style: TextStyle(
                      fontFamily: "Montserrat",
                      fontSize: this.widget.sess!.hight * 3,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF000031)
                    ),
                ),
              )),
          Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.only(
                    left: this.widget.sess!.hight * 5,
                    top: this.widget.sess!.hight * 2),
                child: SizedBox(
                  height: this.widget.sess!.hight * 0.5,
                  width: this.widget.sess!.width * 20,
                  child: Container(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              )),
          // Align(
          //     alignment: Alignment.topLeft,
          //     child: Padding(
          //         padding: EdgeInsets.only(
          //             left: this.widget.sess!.hight * 5,
          //             top: this.widget.sess!.hight * 2),
          //         child: FutureBuilder(
          //             future: SharedPreference().getString("Server"),
          //             builder: (context, snapshot) {
          //               _isReadonlyServer = snapshot.data != "" ? true : false;
          //               if (snapshot.hasData) {
          //                 _Server.text = snapshot.data.toString();
          //                 this.widget.sess!.server = snapshot.data.toString();
          //                 // setState(() {});
          //               }
          //               return Container(
          //                   width: this.widget.sess!.width * 90,
          //                   child: Row(
          //                     children: [
          //                       Container(
          //                         width: this.widget.sess!.width * 72,
          //                         child: Center(
          //                           child: Padding(
          //                             padding: EdgeInsets.only(
          //                                 bottom: this.widget.sess!.hight * 2),
          //                             child: Focus(
          //                               child: TextField(
          //                                 controller: _Server,
          //                                 readOnly: _isReadonlyServer,
          //                                 focusNode: _serverNode,
          //                                 decoration: InputDecoration(
          //                                     icon: Icon(Icons.wifi,
          //                                         size:
          //                                             this.widget.sess!.hight *
          //                                                 4,
          //                                         color: Theme.of(context)
          //                                             .primaryColor),
          //                                     labelText: "Server",
          //                                     labelStyle: TextStyle(
          //                                         fontSize:
          //                                             this.widget.sess!.hight *
          //                                                 2,
          //                                         color: Theme.of(context)
          //                                             .primaryColor)),

          //                                 // onTap: () {
          //                                 //   _ratio = 3.5;
          //                                 // },
          //                                 // onSubmitted: (_) {
          //                                 //   _ratio = 2;
          //                                 // },
          //                               ),
          //                               onFocusChange: (value) {
          //                                 if (!value) {
          //                                   SharedPreference().setString(
          //                                       "Server", _Server.text);
          //                                   this.widget.sess!.server =
          //                                       _Server.text;
          //                                   // print("Enable");
          //                                   setState(() {});
          //                                 }
          //                               },
          //                             ),
          //                           ),
          //                         ),
          //                       ),
          //                       GestureDetector(
          //                         child: Text(
          //                           "Ganti",
          //                           style: TextStyle(
          //                               color: Theme.of(context).primaryColor,
          //                               fontWeight: FontWeight.bold,
          //                               fontFamily: "Montserrat",
          //                               fontSize: this.widget.sess!.hight * 2),
          //                         ),
          //                         onTap: () async {
          //                           await SharedPreference()
          //                               .removeKey("Server");
          //                           this.widget.sess!.server = "";
          //                           // print("Enable");
          //                           setState(() {});
          //                         },
          //                       )
          //                     ],
          //                   ));
          //             }))),
          Align(
              alignment: Alignment.topLeft,
              child: Padding(
                  padding: EdgeInsets.only(
                      left: this.widget.sess!.hight * 5,
                      top: this.widget.sess!.hight * 2),
                  child: FutureBuilder(
                      future: SharedPreference().getString("PartnerCode"),
                      builder: (context, snapshot) {
                        _isReadonly = snapshot.data != "" ? true : false;
                        if (snapshot.hasData) {
                          _PartnerCode.text = snapshot.data.toString();
                        }
                        return Container(
                            width: this.widget.sess!.width * 90,
                            child: Row(
                              children: [
                                Container(
                                  width: this.widget.sess!.width * 72,
                                  child: Center(
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          bottom: this.widget.sess!.hight * 2),
                                      child: TextField(
                                        controller: _PartnerCode,
                                        readOnly: _isReadonly,
                                        decoration: InputDecoration(
                                            icon: Icon(Icons.handshake,
                                                size:
                                                    this.widget.sess!.hight * 4,
                                                color: Theme.of(context)
                                                    .primaryColor),
                                            labelText: "Kode Partner",
                                            labelStyle: TextStyle(
                                                fontSize:
                                                    this.widget.sess!.hight * 2,
                                                color: Theme.of(context)
                                                    .primaryColor)),

                                        // onTap: () {
                                        //   _ratio = 3.5;
                                        // },
                                        // onSubmitted: (_) {
                                        //   _ratio = 2;
                                        // },
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  child: Text(
                                    "Ganti",
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "Montserrat",
                                        fontSize: this.widget.sess!.hight * 2),
                                  ),
                                  onTap: () async {
                                    await SharedPreference()
                                        .removeKey("PartnerCode");
                                    // print("Enable");
                                    setState(() {});
                                  },
                                )
                              ],
                            ));
                      }))),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.only(
                  left: this.widget.sess!.hight * 5,
                  top: this.widget.sess!.hight * 2),
              child: Container(
                width: this.widget.sess!.width * 72,
                child: Center(
                  child: Padding(
                    padding:
                        EdgeInsets.only(bottom: this.widget.sess!.hight * 2),
                    child: TextField(
                      controller: _UserName,
                      decoration: InputDecoration(
                          icon: Icon(Icons.person,
                              size: this.widget.sess!.hight * 4,
                              color: Theme.of(context).primaryColor),
                          labelText: "Username",
                          labelStyle: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: this.widget.sess!.hight * 2,
                          )),
                      // onTap: () {
                      //   _ratio = 3.5;
                      // },
                      // onSubmitted: (_) {
                      //   _ratio = 2;
                      // },
                    ),
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
                padding: EdgeInsets.only(
                    left: this.widget.sess!.hight * 5,
                    top: this.widget.sess!.hight * 2),
                child: Container(
                    width: this.widget.sess!.width * 90,
                    child: Row(
                      children: [
                        Container(
                          width: this.widget.sess!.width * 72,
                          child: Center(
                            child: Padding(
                              padding: EdgeInsets.only(
                                  bottom: this.widget.sess!.hight * 2),
                              child: TextField(
                                controller: _Password,
                                obscureText: !_obscured,
                                decoration: InputDecoration(
                                    icon: Icon(Icons.key,
                                        size: this.widget.sess!.hight * 4,
                                        color: Theme.of(context).primaryColor),
                                    labelText: "Password",
                                    labelStyle: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: this.widget.sess!.hight * 2,
                                    )),

                                // onTap: () {
                                //   _ratio = 3.5;
                                // },
                                // onSubmitted: (_) {
                                //   _ratio = 2;
                                // },
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          child: Icon(
                              _obscured
                                  ? Icons.visibility_rounded
                                  : Icons.visibility_off_rounded,
                              size: this.widget.sess!.hight * 3,
                              color: Theme.of(context).primaryColor),
                          onTap: () {
                            setState(() {
                              _obscured = !_obscured;
                              print("Tabbed");
                            });
                          },
                        )
                      ],
                    ))),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: this.widget.sess!.hight * 2,
                left: this.widget.sess!.width * 20,
                right: this.widget.sess!.width * 20),
            child: SizedBox(
              width: this.widget.sess!.width * 30,
              height: this.widget.sess!.hight * 4,
              child: ElevatedButton(
                child: Text(
                  "Login",
                  style: TextStyle(
                      fontFamily: "Montserrat",
                      fontSize: this.widget.sess!.hight * 2,
                      color: Colors.white
                      ),
                ),
                style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                    ),
                    backgroundColor: MaterialStateProperty.all(
                        Theme.of(context).primaryColor)),
                onPressed: () async {
                  // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DashboardViewController(sess: this.widget.sess,)));
                  const KeyData = "PartnerCode";
                  showLoadingDialog(context, _keyLoader, info: "Begin Login");
                  Map oParam() {
                    return {
                      "RecordOwnerID": _PartnerCode.text,
                      "username": _UserName.text,
                      "password": _Password.text,
                      "LoginDate" : DateTime.now().toString()
                    };
                  }

                  print(oParam());

                  // LoginFill(this.widget.sess, context, oParam: oParam()).logedIn();
                  SharedPreference().setString(KeyData, _PartnerCode.text);
                  var th = await Mod_Auth(this.widget.sess, Parameter: oParam())
                      .Login();

                  if (th != null) {
                    if (th["success"].toString() == "true") {
                      this.widget.sess!.idUser =
                          int.parse(th["unique_id"].toString());
                      this.widget.sess!.NamaUser = th["NamaUser"];
                      this.widget.sess!.KodeUser = th["username"];
                      this.widget.sess!.RecordOwnerID = th["RecordOwnerID"];
                      this.widget.sess!.NamaPartner = th["NamaPartner"];
                      this.widget.sess!.LocationID =int.parse(th["LocationID"].toString());
                      this.widget.sess!.shift = th["Shift"];
                      this.widget.sess!.jadwalShift = th["JadwalShift"];
                      this.widget.sess!.isGantiHari = int.parse(th["isGantiHari"].toString());
                      this.widget.sess!.icon = th["icon"];

                      var xShared = th["unique_id"] +"|" +th["NamaUser"] +"|" +th["username"] +"|" +th["RecordOwnerID"] +"|" +th["LocationID"] +"|" +th["Shift"]+"|"+th["isGantiHari"].toString()+"|"+th["NamaPartner"]+"|"+th["icon"];

                      SharedPreference().setString("accountInfo", xShared);

                      // Update Token

                      var message = FirebaseMessaging.instance;

                      message.getToken().then((value) {
                        Map param(){
                          return{
                            'username'      : _UserName.text,
                            'RecordOwnerID' : _PartnerCode.text,
                            'FireBaseToken' : value.toString()
                          };
                        }

                        var updateToken = Mod_Auth(this.widget.sess, Parameter: param()).UpdateToken().then((value) {
                          if(value['success'].toString() =='true'){
                            print("Update Token Successful");
                          }
                          else{
                            print(value['message']);
                          }
                        });
                      });

                      Navigator.of(context, rootNavigator: true).pop();
                      // Navigator.of(context).pop();
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  Dashboard(this.widget.sess)));
                    } else {
                      Navigator.of(context, rootNavigator: true).pop();
                      await messageBox(
                          context: context,
                          title: "Gagal Login",
                          message: "Gagal Login :" + th["message"].toString());
                    }
                  }
                },
              ),
            ),
          ),
          // Padding(
          //   padding: EdgeInsets.fromLTRB(0, this.widget.sess!.hight * 1, 0, 0),
          //   child: Center(
          //     child: Text(
          //       "atau"
          //     ),
          //   ),
          // ),
          // Padding(
          //   padding: EdgeInsets.only(
          //       top: this.widget.sess!.hight * 1,
          //       left: this.widget.sess!.width * 20,
          //       right: this.widget.sess!.width * 20),
          //   child: SizedBox(
          //     width: this.widget.sess!.width * 30,
          //     height: this.widget.sess!.hight * 4,
          //     child: ElevatedButton(
          //       child: Text(
          //         "Daftar",
          //         style: TextStyle(
          //             fontFamily: "Montserrat",
          //             fontSize: this.widget.sess!.hight * 2,
          //             color: Theme.of(context).primaryColor
          //           ),
          //       ),
          //       style: ButtonStyle(
          //           shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          //             RoundedRectangleBorder(
          //               borderRadius: BorderRadius.circular(18.0),
          //               side: BorderSide(color: Theme.of(context).primaryColor)
          //             ),
          //           ),
          //           backgroundColor: MaterialStateProperty.all(Colors.white),
          //         ),
          //       onPressed: () async {
          //         Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterMobilePotrait(this.widget.sess,)));
          //       },
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
