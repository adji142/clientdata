import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:mobilepatrol/general/dialog.dart';
import 'package:mobilepatrol/general/session.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobilepatrol/models/patroli.dart';

class FormCheckIn extends StatefulWidget {
  final session sess;
  final String KodeCheckPoint;
  final String NamaCheckPoint;
  FormCheckIn(this.sess, this.KodeCheckPoint, this.NamaCheckPoint);

  @override
  _FormCheckInState createState() => _FormCheckInState();
}

class _FormCheckInState extends State<FormCheckIn> {
  final ImagePicker _picker = ImagePicker();

  final GlobalKey<State> _keyLoader = new GlobalKey<State>();

  DateTime? _tanggal;
  File? imageFile;
  List? pathext;
  String? extentionPath;
  String image64 = "";
  Position? _currentPosition;

  bool _isbuttondisable = false;
  bool _issaving = false;

  String _shift = "";
  String _kodeShift = "";
  // Position _posisi = new Position();
  TextEditingController _catatan = TextEditingController();

  _openCamera(BuildContext context) async {
    final ImagePicker _picker = ImagePicker();

    await _picker
        .pickImage(source: ImageSource.camera, maxHeight: 600)
        .then((value) {
      setState(() {
        imageFile = File(value!.path);
        pathext = imageFile!.uri.toString().split("/");
        extentionPath = pathext![pathext!.length - 1].toString();

        if (imageFile != null) {
          final bites = imageFile!.readAsBytesSync();
          image64 = base64Encode(bites);
        }
      });
      _setEnableCommand();
      // Navigator.of(context).pop();
    });
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
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() => _currentPosition = position);
      _setEnableCommand();
    }).catchError((e) {
      debugPrint(e);
    });
  }

  void _getLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  void _timeChange() {
    final DateTime now = DateTime.now().toLocal();
    final String temp = DateFormat('jm').format(now).trim();
    final ampm = temp.substring(temp.length - 2, temp.length);
    String xShift = "";
    int shift = 0;

    if (this.widget.sess.jadwalShift.length > 0) {
      // print(this.widget.sess!.jadwalShift);
      for (var i = 0; i < this.widget.sess.jadwalShift.length; i++) {
        var mulai = this
            .widget
            .sess
            .jadwalShift[i]["MulaiBekerja"]
            .toString()
            .split(":");
        var selesai = this
            .widget
            .sess
            .jadwalShift[i]["SelesaiBekerja"]
            .toString()
            .split(":");
        var isGantiHari =
            int.parse(this.widget.sess.jadwalShift[i]["GantiHari"]);

        if (mulai.isNotEmpty) {
          DateTime defTime =
              DateTime(now.year, now.month, now.day, 0, 0, 1).toLocal();

          // print(defTime);
          DateTime jamMulai = DateTime(
              now.year,
              now.month,
              now.day,
              int.parse(mulai[0]),
              int.parse(mulai[1]),
              int.parse(mulai[0].split(".")[0]));
          // DateTime jamSelesai = DateTime.utc(now.year, now.month, isGantiHari == 1 ? now.day +1 : now.day , int.parse(selesai[0]), int.parse(selesai[1]), int.parse(selesai[0].split(".")[0]));
          DateTime jamSelesai = DateTime(
              now.year,
              now.month,
              now.day,
              int.parse(selesai[0]),
              int.parse(selesai[1]),
              int.parse(selesai[0].split(".")[0]));

          // print(defTime.isAfter(now));
          if (isGantiHari == 1 &&
              now.isAfter(defTime) &&
              now.isBefore(jamSelesai)) {
            print("IN");
            jamMulai = DateTime(
                now.year,
                now.month,
                now.day - 1,
                int.parse(mulai[0]),
                int.parse(mulai[1]),
                int.parse(mulai[0].split(".")[0]));
          } else {
            jamSelesai = DateTime(
                now.year,
                now.month,
                now.day + 1,
                int.parse(selesai[0]),
                int.parse(selesai[1]),
                int.parse(selesai[0].split(".")[0]));
          }
          // print(jamMulai);

          if (now.isAfter(jamMulai.toLocal()) &&
              now.isBefore(jamSelesai.toLocal())) {
            xShift = this
                .widget
                .sess
                .jadwalShift[i]["NamaShift"]
                .toString()
                .toUpperCase();
            shift = int.parse(this.widget.sess.jadwalShift[i]["id"]);
          }

          // if (DateTime.utc(1900, 1, 1, int.parse(mulai[0]), int.parse(mulai[1]), int.parse(mulai[0].split(".")[0])).hour <= now.hour && DateTime.utc(1900, 1, 1, int.parse(selesai[0]), int.parse(selesai[1]), int.parse(selesai[0].split(".")[0])).hour >= now.hour) {
          //   xShift = this.widget.sess!.jadwalShift[i]["NamaShift"].toString();
          //   shift = int.parse(this.widget.sess!.jadwalShift[i]["id"]);
          //   // 22 < 07 && 22 > 15 -> false
          //   // 22 < 15 && 22 > 23 ->
          //   // 23 < 23 && 22 > 07
          // }
        }
      }
    }

    // if (ampm == "AM") {
    //   // AM
    //   //------------------------------------------------------------------------
    //   if (now.hour < DateTime.utc(1900, 1, 1, 7, 0, 0).hour) {
    //     shift = 3;
    //   } else {
    //     shift = 1;
    //   }
    //   //------------------------------------------------------------------------
    // } else {
    //   // PM
    //   //------------------------------------------------------------------------
    //   if (now.hour < DateTime.utc(1900, 1, 1, 15, 0, 0).hour) {
    //     shift = 1;
    //   } else if (now.hour >= DateTime.utc(1900, 1, 1, 15, 0, 0).hour &&
    //       now.hour < DateTime.utc(1900, 1, 1, 23, 0, 0).hour) {
    //     shift = 2;
    //   } else {
    //     shift = 3;
    //   }
    //   //------------------------------------------------------------------------
    // }

    setState(() {
      // _kodeShift = xshift.toString();
      _shift = xShift.toString();
      _kodeShift = shift.toString();
      _tanggal = now;
    });
  }

  void _setEnableCommand() {
    // if(_currentPosition != null){
    //   if("${_currentPosition!.latitude},${_currentPosition!.longitude}" == "," || image64 == ""){
    //     _isbuttondisable =true;
    //   }
    //   else{
    //     _isbuttondisable = false;
    //   }
    // }
    // else{
    //   _isbuttondisable = true;
    // }
    setState(() {});
  }

  @override
  void initState() {
    _timeChange();
    _catatan.text = "";
    _getCurrentPosition();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Checkin : " + widget.NamaCheckPoint),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Padding(
        padding: EdgeInsets.all(this.widget.sess.width * 2),
        child: _tanggal == null
            ? Container()
            : ListView(
                children: [
                  //User Section
                  //------------------------------------------------------------------
                  Card(
                    color: Theme.of(context).primaryColorLight,
                    child: ListTile(
                      leading: CircleAvatar(
                        child: Icon(Icons.person),
                      ),
                      title: Text(widget.sess.NamaUser,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor)),
                      subtitle: Text(
                          DateFormat("dd/MM/yyyy hh:mm:ss").format(_tanggal!),
                          style:
                              TextStyle(fontSize: 12, color: Colors.black54)),
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.qr_code),
                    title: Text(
                      "Check Point",
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                    subtitle: Text(
                      widget.NamaCheckPoint,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.red),
                    ),
                  ),

                  ListTile(
                    leading: Icon(Icons.location_pin),
                    title: Text(
                      "Lokasi",
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                    subtitle: _currentPosition == null
                        ? Text("Baca Informasi Lokasi...")
                        : Text(
                            "${_currentPosition!.latitude}, ${_currentPosition!.longitude}",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                    trailing: IconButton(
                      icon: Icon(Icons.refresh),
                      onPressed: () {
                        // _currentPosition = Position();
                        setState(() {});
                        // _getLocation();
                        _getCurrentPosition();
                        setState(() {});
                      },
                    ),
                  ),

                  ListTile(
                    leading: Icon(Icons.photo),
                    title: Text(
                      "Photo",
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                    subtitle: imageFile == null
                        ? Container(
                            child: Text("Ambil Photo"),
                          )
                        : Card(
                            child: Padding(
                            padding: EdgeInsets.all(this.widget.sess.width * 2),
                            child: Image.file(File(imageFile!.path)),
                          )),
                    trailing: IconButton(
                      icon: Icon(Icons.camera_alt),
                      onPressed: () {
                        _openCamera(context);
                      },
                    ),
                  ),

                  ListTile(
                    leading: Icon(Icons.subject),
                    title: TextField(
                      controller: _catatan,
                      minLines: 4,
                      maxLines: 15,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      onChanged: (_) {
                        setState(() {});
                      },
                    ),
                  ),

                  ElevatedButton(
                    child: _issaving == true
                        ? CircularProgressIndicator()
                        : Text(
                            "Proses Data",
                            style: TextStyle(color: Colors.white),
                          ),
                    style: ButtonStyle(
                        shape:MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0),
                      // side: BorderSide(color: Colors.red)
                    )),
                    backgroundColor: MaterialStateProperty.all(Theme.of(context).primaryColor)),
                    onPressed: _isbuttondisable
                        ? null
                        : () async {
                            showLoadingDialog(context, _keyLoader,
                                info: "Begin Login");
                            Map oParam() {
                              return {
                                'RecordOwnerID': this.widget.sess.RecordOwnerID,
                                'KodeCheckPoint': this.widget.KodeCheckPoint,
                                'LocationID':
                                    this.widget.sess.LocationID.toString(),
                                'TanggalPatroli': _tanggal.toString(),
                                'KodeKaryawan': this.widget.sess.KodeUser,
                                'Koordinat':
                                    "${_currentPosition!.latitude},${_currentPosition!.longitude}",
                                'Image': image64.toString(),
                                'Catatan': _catatan.text,
                                'ImageName': extentionPath,
                                'Shift': _kodeShift.toString()
                              };
                            }

                            print(image64);
                            print(oParam);

                            if(image64 == ""){
                              await messageBox(context: context,title: "Infomasi",message: "Harus Melampirkan Foto Kondisi Lokasi");
                              Navigator.of(context, rootNavigator: true).pop();
                              return;
                            }

                            var temp = await Mod_Patroli(this.widget.sess,Parameter: oParam()).save().then((value) async {
                              if (value["success"]) {
                                Navigator.of(context, rootNavigator: true).pop();
                                Navigator.of(context).pop();
                              } else {
                                Navigator.of(context, rootNavigator: true).pop();
                                await messageBox(
                                    context: context,
                                    title: "Infomasi",
                                    message: value["message"]);
                              }
                            });

                          },
                  )
                ],
              ),
      ),
    );
  }
}
