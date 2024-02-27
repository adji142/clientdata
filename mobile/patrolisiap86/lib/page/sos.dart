import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobilepatrol/general/dialog.dart';
import 'package:mobilepatrol/general/session.dart';
import 'package:mobilepatrol/models/sos.dart';

class sosMessage extends StatefulWidget {
  final session? sess;
  final String? uID;
  sosMessage(this.sess, this.uID);

  @override
  _sosState createState() => _sosState();
}

class _sosState extends State<sosMessage> {
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();

  Position? _currentPosition;

  LatLng ? _center;

  late GoogleMapController mapController;


  File? imageFile_1;
  String image64_1 = "";

  File? imageFile_2;
  String image64_2 = "";

  File? imageFile_3;
  String image64_3 = "";

  List? pathext;
  String? extentionPath_1 = "";
  String? extentionPath_2 = "";
  String? extentionPath_3 = "";

  bool _isSaved = false;

  TextEditingController _detailPesan = TextEditingController();
  _openCamera_1(BuildContext context) async {
    final ImagePicker _picker = ImagePicker();

    await _picker.pickImage(source: ImageSource.camera, maxHeight: 600).then((value) {
      setState(() {
        imageFile_1 = File(value!.path);
        pathext = imageFile_1!.uri.toString().split("/");
        extentionPath_1 = pathext![pathext!.length - 1].toString();

        if (imageFile_1 != null) {
          final bites = imageFile_1!.readAsBytesSync();
          image64_1 = base64Encode(bites);
          print(image64_1);
        }
      });
      // Navigator.of(context).pop();
    });
  }

  _openCamera_2(BuildContext context) async {
    final ImagePicker _picker = ImagePicker();

    await _picker.pickImage(source: ImageSource.camera, maxHeight: 600).then((value) {
      setState(() {
        imageFile_2 = File(value!.path);
        pathext = imageFile_2!.uri.toString().split("/");
        extentionPath_2 = pathext![pathext!.length - 1].toString();

        if (imageFile_2 != null) {
          final bites = imageFile_2!.readAsBytesSync();
          image64_2 = base64Encode(bites);
        }
      });
      // Navigator.of(context).pop();
    });
  }
  
  _openCamera_3(BuildContext context) async {
    final ImagePicker _picker = ImagePicker();

    await _picker.pickImage(source: ImageSource.camera, maxHeight: 600).then((value) {
      setState(() {
        imageFile_3 = File(value!.path);
        pathext = imageFile_3!.uri.toString().split("/");
        extentionPath_3 = pathext![pathext!.length - 1].toString();

        if (imageFile_3 != null) {
          final bites = imageFile_3!.readAsBytesSync();
          image64_3 = base64Encode(bites);
        }
      });
      // Navigator.of(context).pop();
    });
  }

  void _onMapCreated(GoogleMapController controller) {
      mapController = controller;
   }

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }
  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();
    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high).then((Position position) {
      setState(() {
        _currentPosition = position;
      });
    }).catchError((e) {
      debugPrint(e);
    });
  }

  @override
  void initState() {
    _getCurrentPosition();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        bottomNavigationBar: BottomAppBar(
          child: ElevatedButton(
            style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0),)),
              backgroundColor: MaterialStateProperty.all(Colors.red)
            ),
            child: Text("Simpan"),
            onPressed: () async{
              showLoadingDialog(context, _keyLoader, info: "Saving");
              Map oParam(){
                return {
                  "id"              : this.widget.uID,
                  'RecordOwnerID'   : this.widget.sess!.RecordOwnerID,
                  'LocationID'      : this.widget.sess!.LocationID.toString(),
                  'KodeKaryawan'    : this.widget.sess!.KodeUser,
                  'Comment'         : _detailPesan.text,
                  'Image1'          : extentionPath_1,
                  'Image2'          : extentionPath_2,
                  'Image3'          : extentionPath_3,
                  'Koordinat'       : "${_currentPosition!.latitude},${_currentPosition!.longitude}",
                  'Image_Base64_1'  : image64_1 == null ? "" : image64_1,
                  'Image_Base64_2'  : image64_2 == null ? "" : image64_2,
                  'Image_Base64_3'  : image64_3 == null ? "" : image64_3,
                  'SubmitDate'      : DateTime.now().toString(),
                  'VoiceNote'       : "",
                  "formMode"        : "edit"
                };
              }
              print(image64_1);
              var oSave = await Mod_SOS(this.widget.sess, oParam()).create().then((value) {
                if(value["success"].toString() == "true"){
                  Navigator.of(context, rootNavigator: true).pop();
                  messageBox(context: context, title: "Informasi", message: "Data Berhasil dikirim ke rekan terdekat");
                  Navigator.of(context).pop();
                  setState(() {
                    _isSaved = true;
                  });
                }
                else{
                  Navigator.of(context, rootNavigator: true).pop();
                  messageBox(context: context, title: "ERROR", message: "Sistem gagal menyimpan data : " + value["message"].toString());
                }
              });
            },
          ),
        ),
        body: Container(
          width: double.infinity,
          height: this.widget.sess!.hight * 100,
          child: ListView(
            // mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Text("data"),
              // Text("data2")
              Container(
                width: double.infinity,
                height: this.widget.sess!.hight * 30,
                color: Theme.of(context).primaryColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: this.widget.sess!.hight * 1, left: this.widget.sess!.hight * 2),
                          child: Text(
                            "Emergency",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              // fontFamily: "Roboto",
                              fontSize: this.widget.sess!.hight * 4,
                              fontWeight: FontWeight.normal,
                              color: Colors.white
                            ),
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: this.widget.sess!.hight * 1 ,left: this.widget.sess!.hight * 2),
                          child: Text(
                            "Request Send !",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              // fontFamily: "Roboto",
                              fontSize: this.widget.sess!.hight * 4,
                              fontWeight: FontWeight.normal,
                              color: Colors.white
                            ),
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: this.widget.sess!.hight * 2 ,top: this.widget.sess!.hight * 2 ,bottom: this.widget.sess!.hight * 1),
                          child: Text(
                            "Tetap Tenang!",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontFamily: "Arial",
                              fontSize: this.widget.sess!.hight * 3,
                              fontWeight: FontWeight.normal,
                              color: Colors.white
                            ),
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: this.widget.sess!.hight * 2 ,bottom: this.widget.sess!.hight * 3),
                          child: Text(
                            "Masukkan Detail Informasi berikut",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontFamily: "Arial",
                              fontSize: this.widget.sess!.hight * 2,
                              fontWeight: FontWeight.normal,
                              color: Colors.white
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                height: this.widget.sess!.hight * 20,
                // color:  Colors.amber,
                child: _currentPosition != null ? 
                GoogleMap(
                  onMapCreated: _onMapCreated,
                  initialCameraPosition: CameraPosition(
                    target: LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
                    zoom: 17,
                  ),
                  markers: {
                    Marker(
                      markerId: MarkerId("SOS Value"),
                      position: LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
                    )
                  }
                ):Container(),
              ),
              Container(
                width: double.infinity,
                height: this.widget.sess!.hight * 3,
                child: Center(
                  child: Text("Upload Gambar"),
                ),
              ),
              Container(
                width: double.infinity,
                height: this.widget.sess!.hight * 25,
                // color: Colors.black,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(this.widget.sess!.width * 1),
                      child: GestureDetector(
                        child: SizedBox(
                          width: this.widget.sess!.width * 30,
                          height: this.widget.sess!.hight * 25,
                          child: Card(
                            child: imageFile_1 == null ? Icon(Icons.image) : Image.file(File(imageFile_1!.path)),
                          ),
                        ),
                        onTap: (){
                          _openCamera_1(context);
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(this.widget.sess!.width * 1),
                      child: GestureDetector(
                        child: SizedBox(
                          width: this.widget.sess!.width * 30,
                          height: this.widget.sess!.hight * 25,
                          child: Card(
                            child: imageFile_2 == null ? Icon(Icons.image) : Image.file(File(imageFile_2!.path)),
                          ),
                        ),
                        onTap: (){
                          _openCamera_2(context);
                        },
                      )
                    ),
                    Padding(
                      padding: EdgeInsets.all(this.widget.sess!.width * 1),
                      child: GestureDetector(
                        child: SizedBox(
                          width: this.widget.sess!.width * 30,
                          height: this.widget.sess!.hight * 25,
                          child: Card(
                            child: imageFile_3 == null ? Icon(Icons.image) : Image.file(File(imageFile_3!.path)),
                          ),
                        ),
                        onTap: (){
                          _openCamera_3(context);
                        },
                      )
                    )
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                height: this.widget.sess!.hight * 15,
                child: Padding(
                  padding: EdgeInsets.all(this.widget.sess!.width * 2),
                  child: TextField(
                    // autofocus: true,
                    controller: _detailPesan,
                    textAlign: TextAlign.start,
                    textInputAction: TextInputAction.done,
                    maxLines: 3,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      labelText: "Masukan Detail Informasi",
                      labelStyle: TextStyle(
                        color: Theme.of(context).primaryColorDark,
                        fontWeight: FontWeight.bold,
                        // fontSize: this.widget.sess!.width * 10
                      )
                    ),
                  ),
                ),
                // child: Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                    
                //     // Column(
                //     //   mainAxisAlignment: MainAxisAlignment.center,
                //     //   children: [
                //     //     Padding(
                //     //       padding: EdgeInsets.all(this.widget.sess!.width * 2),
                //     //       child: GestureDetector(
                //     //         child: Container(
                //     //           width: this.widget.sess!.width * 15,
                //     //           height: this.widget.sess!.width * 15,
                //     //           // color: Colors.grey,
                //     //           decoration: BoxDecoration(
                //     //             color: Colors.grey,
                //     //             borderRadius: BorderRadius.all(Radius.circular(this.widget.sess!.width * 3))
                //     //           ),
                //     //           child: Icon(
                //     //             Icons.mic,
                //     //             color: Colors.white,
                //     //             size: this.widget.sess!.width * 7,
                //     //           ),
                //     //         ),
                //     //         onTap: (){},
                //     //       ),
                //     //     ),
                //     //     Text("AUDIO")
                //     //   ],
                //     // ),
                //     // Column(
                //     //   mainAxisAlignment: MainAxisAlignment.center,
                //     //   children: [
                //     //     Padding(
                //     //       padding: EdgeInsets.all(this.widget.sess!.width * 2),
                //     //       child: GestureDetector(
                //     //         child: Container(
                //     //           width: this.widget.sess!.width * 15,
                //     //           height: this.widget.sess!.width * 15,
                //     //           decoration: BoxDecoration(
                //     //             color: Colors.grey,
                //     //             borderRadius: BorderRadius.all(Radius.circular(this.widget.sess!.width * 3))
                //     //           ),
                //     //           child: Icon(
                //     //             Icons.edit_document,
                //     //             color: Colors.white,
                //     //             size: this.widget.sess!.width * 7,
                //     //           ),
                //     //         ),
                //     //         onTap: (){
                              
                //     //         },
                //     //       ),
                //     //     ),
                //     //     Text("TEXT")
                //     //   ],
                //     // ),
                //   ],
                // ),
              )
            ],
          ),
        ),
      ), 
      onWillPop: (){
        Future<bool> donoting;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content:
                Text('Pop Screen Disabled. You cannot go to previous screen.'),
            backgroundColor: Colors.red,
          ),
        );
        return Future.value(_isSaved);
      }
    );
  }
}
