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
import 'package:photo_view/photo_view.dart';

class sosCallBack extends StatefulWidget {
  final session? sess;
  final String? uID;
  sosCallBack(this.sess, this.uID);

  @override
  _sosCallBackState createState() => _sosCallBackState();
}

class _sosCallBackState extends State<sosCallBack> {
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
    Map oParam(){
      return {
        "id"              : this.widget.uID,
        'RecordOwnerID'   : this.widget.sess!.RecordOwnerID,
        'KodeLokasi'      : this.widget.sess!.LocationID.toString(),
      };
    }
    return Scaffold(
      body: FutureBuilder(
        future: Mod_SOS(this.widget.sess, oParam()).read(),
        builder: (context, snapshot){
          if(snapshot.hasData){
            if(snapshot.data!["data"].length > 0){
              List<String> position = snapshot.data!["data"][0]["Koordinat"].toString().split(",");
              _detailPesan.text = snapshot.data!["data"][0]["Comment"];
              print(this.widget.sess!.server+"Assets/images/SOS/"+snapshot.data!["data"][0]["Image1"]);
              return Container(
                width: double.infinity,
                height: this.widget.sess!.hight * 100,
                child: ListView(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      height: this.widget.sess!.hight * 30,
                      // color:  Colors.amber,
                      child: _currentPosition != null ? 
                      GoogleMap(
                        onMapCreated: _onMapCreated,
                        initialCameraPosition: CameraPosition(
                          target: LatLng(double.parse(position[0]), double.parse(position[1])),
                          zoom: 18,
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
                        child: Text("Detail Gambar"),
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
                                  child: snapshot.data!["data"][0]["Image1"] != "" 
                                    ? Image.network(this.widget.sess!.server+"Assets/images/SOS/"+snapshot.data!["data"][0]["Image1"]) 
                                    : Center(
                                        child: Text("No Image"),
                                      )
                                ),
                              ),
                              onTap: snapshot.data!["data"][0]["Image1"] == "" ? null : (){
                                // _openCamera_1(context);
                                PhotoView(
                                  imageProvider: NetworkImage(this.widget.sess!.server+"Assets/images/SOS/"+snapshot.data!["data"][0]["Image1"])
                                );
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
                                  child: snapshot.data!["data"][0]["Image2"] != "" 
                                    ? Image.network(this.widget.sess!.server+"Assets/images/SOS/"+snapshot.data!["data"][0]["Image2"]) 
                                    : Center(
                                        child: Text("No Image"),
                                      )
                                ),
                              ),
                              onTap: snapshot.data!["data"][0]["Image2"] == "" ? null : (){
                                // _openCamera_2(context);
                                PhotoView(
                                  imageProvider: NetworkImage(this.widget.sess!.server+"Assets/images/SOS/"+snapshot.data!["data"][0]["Image2"])
                                );
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
                                  child: snapshot.data!["data"][0]["Image3"] != "" 
                                    ? Image.network(this.widget.sess!.server+"Assets/images/SOS/"+snapshot.data!["data"][0]["Image3"]) 
                                    : Center(
                                        child: Text("No Image"),
                                      )
                                ),
                              ),
                              onTap: snapshot.data!["data"][0]["Image3"] == "" ? null : (){
                                // _openCamera_3(context);
                                PhotoView(
                                  imageProvider: NetworkImage(this.widget.sess!.server+"Assets/images/SOS/"+snapshot.data!["data"][0]["Image3"])
                                );
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
                          readOnly: true,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                            labelText: "Detail Informasi",
                            labelStyle: TextStyle(
                              color: Theme.of(context).primaryColorDark,
                              fontWeight: FontWeight.bold,
                              // fontSize: this.widget.sess!.width * 10
                            )
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              );
            }
            else{
              return Container();
            }
            
          }
          else{
            return Container();
          }
        }
      )
    );
  }
}
