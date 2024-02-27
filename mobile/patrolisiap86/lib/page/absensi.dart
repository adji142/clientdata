import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobilepatrol/general/dialog.dart';
import 'package:mobilepatrol/general/session.dart';
import 'package:mobilepatrol/models/absensi.dart';
import 'package:mobilepatrol/models/shift.dart';
import 'package:flutter_face_api/face_api.dart' as Regula;

class FormAbsensi extends StatefulWidget {
  final session sess;
  final String shift;
  FormAbsensi(this.sess, this.shift);

  @override
  _FormAbsensi createState() => _FormAbsensi();
}

class _FormAbsensi extends State<FormAbsensi> {
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();

  var image1 = new Regula.MatchFacesImage();
  var image2 = new Regula.MatchFacesImage();

  List ? dataJadwal= [];
  List ? dataAbsen = [];
  List ? dataKaryawan = [];

  bool isMatch = false;

  Position? _currentPosition;

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
    // showLoadingDialog(context, _keyLoader, info: "Geting Current Location");

    final hasPermission = await _handleLocationPermission();
    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high).then((Position position) {
      // Navigator.of(context, rootNavigator: true).pop();
      setState(() => _currentPosition = position);
      // _setEnableCommand();
    }).catchError((e) {
      // Navigator.of(context, rootNavigator: true).pop();
      debugPrint(e);
    });
  }

  void _getLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  Future<Map>_getJadwal() async{
    String nowDate = DateTime.now().year.toString() + "-" + DateTime.now().month.toString() + "-" + DateTime.now().day.toString();
    Map oParam(){
      return {
        'TglAwal'   : dataAbsen!.length == 0 ? nowDate : dataAbsen![0]["Checkin"] ,
        'TglAkhir'  : nowDate,
        'id'        : '',
        'RecordOwnerID' : this.widget.sess.RecordOwnerID,
        'NIK'       : this.widget.sess.KodeUser,
        'source'    : "mobile"
      };
    }

    print(oParam());
    // await Mod_Shift(this.widget.sess, oParam()).getJadwal().then((value) {
    //   if(value["data"].length == 0){
    //     messageBox(context: context, title: "Informasi", message: "Data Jadwal Belum dibuat");
    //     Navigator.of(context).pop();
    //   }
    // });

    var temp = await Mod_Shift(this.widget.sess, oParam()).getJadwal();

    // print(temp);
    
    return temp;
  
  }

  Future<Map>_getAbsen() async{
    int monthLength = (DateTime.now().month.toString()).length;
    int dayLength = (DateTime.now().day.toString()).length;
    int hourLength = (DateTime.now().hour.toString()).length;
    int minLength = (DateTime.now().minute.toString()).length;
    int secLength = (DateTime.now().second.toString()).length;
    
    String nowDate = DateTime.now().year.toString() + "-" +(monthLength == 1 ? "0"+DateTime.now().month.toString() : DateTime.now().month.toString()) + "-" + (dayLength == 1 ? "0"+DateTime.now().day.toString() : DateTime.now().day.toString()) + " " + (hourLength == 1 ? "0"+DateTime.now().hour.toString(): DateTime.now().hour.toString()) +":" + (minLength == 1 ? "0"+DateTime.now().minute.toString():DateTime.now().minute.toString()) +":"+DateTime.now().second.toString();
    Map oParam(){
      return {
        'KodeLokasi'    : this.widget.sess.LocationID.toString(),
        'RecordOwnerID' : this.widget.sess.RecordOwnerID,
        'KodeKaryawan'  : this.widget.sess.KodeUser,
        'Tanggal'       : nowDate
      };
    }
    var temp = await Mod_Absensi(this.widget.sess, oParam()).Read();
    return temp;
  }
  

  Future<void> initPlatformState() async {
    Regula.FaceSDK.init().then((json) {
      var response = jsonDecode(json);
      if (!response["success"]) {
        print("Init failed: ");
        print(json);
      }
    });
  }

  _fetchJadwal() async{
    var temp = await _getJadwal();
    // print(temp["data"].length);
    dataJadwal = temp["data"];
    // setState(() => {});
  }

  _fetchAbsen() async{
    var temp = await _getAbsen();
    dataAbsen = temp["data"];
    setState(() => {});
  }

  _fetchData() async{
    var temAbsen = await _getAbsen();
    dataAbsen = temAbsen["data"];
    setState(() => {});

    var temJadwal = await _getJadwal();
    dataJadwal = temJadwal["data"];
    setState(() => {});
  }

  Future<void> matchFaces(String formType) async {
    print("Processing00");
    print(image1.bitmap);
    print(image2.bitmap);
    if (image1.bitmap == null ||
        image1.bitmap == "" ||
        image2.bitmap == null ||
        image2.bitmap == ""){};
    // setState(() => _similarity = "Processing...");
    var request = new Regula.MatchFacesRequest();
    request.images = [image1, image2];
    Regula.FaceSDK.matchFaces(jsonEncode(request)).then((value) {
      var response = Regula.MatchFacesResponse.fromJson(json.decode(value));
      print(response);
      Regula.FaceSDK.matchFacesSimilarityThresholdSplit(jsonEncode(response!.results), 0.9).then((str) async {
        var split = Regula.MatchFacesSimilarityThresholdSplit.fromJson(json.decode(str));
        print("printing "+ (split!.matchedFaces[0]!.similarity! * 100 > 95).toString());
        if(split.matchedFaces.length > 0){
          if(split.matchedFaces[0]!.similarity! * 100 > 95){
            // return true;
            // isMatch = true;

            if(formType == "in"){
              Map dataParam(){
                return {
                  "RecordOwnerID" : this.widget.sess.RecordOwnerID,
                  "LocationID"    : this.widget.sess.LocationID.toString(),
                  "KodeKaryawan"  : this.widget.sess.KodeUser,
                  "KoordinatIN"   : _currentPosition == null ? "" : "${_currentPosition!.latitude},${_currentPosition!.longitude}",
                  "ImageIN"       : image2.bitmap,
                  "Tanggal"       : DateTime.now().year.toString() + "-"+ DateTime.now().month.toString() + "-" + DateTime.now().day.toString(),
                  "Shift"         : dataJadwal![0]["ShiftID"],
                  "Checkin"       : DateTime.now().toString(),
                  "CreatedOn"     : DateTime.now().toString(),
                  "formMode"      : formType
                };
              }
              print(dataParam);

              await Mod_Absensi(this.widget.sess, dataParam()).Create().then((value) async{
                if(value["success"]){
                  Navigator.of(context, rootNavigator: true).pop();
                  await messageBox(
                    context: context, 
                    title: "Infomasi", 
                    message: "Berhasil Checkin"
                  );
                  Navigator.of(context).pop();
                }
                else{
                  Navigator.of(context, rootNavigator: true).pop();
                  await messageBox(
                    context: context, 
                    title: "Infomasi", 
                    message: value["message"]
                  );
                }
              });
            }
            else if(formType == "out"){
              print(image2.bitmap);
              Map dataParam(){
                return {
                  "id"            : dataAbsen![0]["id"].toString(),
                  "RecordOwnerID" : this.widget.sess.RecordOwnerID,
                  "LocationID"    : this.widget.sess.LocationID.toString(),
                  "KodeKaryawan"  : this.widget.sess.KodeUser,
                  "KoordinatOUT"  : _currentPosition == null ? "" : "${_currentPosition!.latitude},${_currentPosition!.longitude}",
                  "ImageOUT"      : image2.bitmap,
                  "Shift"         : dataJadwal![0]["NamaShift"],
                  "CheckOut"      : DateTime.now().toString(),
                  "UpdatedOn"     : DateTime.now().toString(),
                  "formMode"      : formType
                };
              }

              print(dataParam());

              await Mod_Absensi(this.widget.sess, dataParam()).Create().then((value) async{
                if(value["success"]){
                  Navigator.of(context, rootNavigator: true).pop();
                  await messageBox(
                    context: context, 
                    title: "Infomasi", 
                    message: "Berhasil Checkout"
                  );
                  Navigator.of(context).pop();
                }
                else{
                  Navigator.of(context, rootNavigator: true).pop();
                  await messageBox(
                    context: context, 
                    title: "Infomasi", 
                    message: value["message"]
                  );
                }
              });
            }
            else{
                Navigator.of(context, rootNavigator: true).pop();
                messageBox(context: context, title: "info", message: "Invalid Form Type");
            }

            
          }
          else{
            Navigator.of(context, rootNavigator: true).pop();
            await messageBox(
              context: context, 
              title: "Infomasi", 
              message: "Face not Match"
            );
          }
        }
        else{
          Navigator.of(context, rootNavigator: true).pop();
          await messageBox(
            context: context, 
            title: "Infomasi", 
            message: "Face not Found"
          );
        }
      }).onError((error, stackTrace) async{
        print("ini ada error : " + error.toString());
        Navigator.of(context, rootNavigator: true).pop();
        await messageBox(
            context: context, 
            title: "Infomasi", 
            message: "Wajah tidak ada disistem"
          );
      });
    });
  }

  @override
  void initState() {
    _fetchData();
    // print(dataJadwal);
    super.initState();
    initPlatformState();

    const EventChannel('flutter_face_api/event/video_encoder_completion').receiveBroadcastStream().listen((event) {
      var completion = Regula.VideoEncoderCompletion.fromJson(json.decode(event))!;
      print("VideoEncoderCompletion:");
      print("    success:  ${completion.success}");
      print("    transactionId:  ${completion.transactionId}");
    });
    const EventChannel('flutter_face_api/event/onCustomButtonTappedEvent').receiveBroadcastStream().listen((event) {
      print("Pressed button with id: $event");
    });
    const EventChannel('flutter_face_api/event/livenessNotification').receiveBroadcastStream().listen((event) {
      var notification = Regula.LivenessNotification.fromJson(json.decode(event));
      print("LivenessProcessStatus: ${notification!.status}");
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // if(dataJadwal!.length == 0){
    //   // print("xxxxxx");
    //   messageBox(context: context, title: "Informasi", message: "Data Jadwal Belum dibuat");
    //   Navigator.of(context).pop();
    // }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          "Absensi",
          style: TextStyle(
            color: Colors.white
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.all(5),
            child: Text(
              "V " + this.widget.sess.appVersion,
              style: TextStyle(
                color: Colors.white
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: dataJadwal!.length > 0 ? Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(this.widget.sess.width * 2,
                  this.widget.sess.width * 2, 0, this.widget.sess.width * 2),
              child: Container(
                width: this.widget.sess.width * 40,
                child: ElevatedButton(
                  child: Text("Check In"),
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      )),
                      backgroundColor: MaterialStateProperty.all(Colors.green)),
                  onPressed: dataAbsen!.length > 0 ? null :() async{
                    showLoadingDialog(context, _keyLoader, info: "Begin Scaning");
                    _getCurrentPosition();
                    final ImagePicker _picker = ImagePicker();

                    await _picker.pickImage(
                      source: ImageSource.camera, 
                      maxHeight: 600,
                      preferredCameraDevice: CameraDevice.front
                    ).then((value) {
                      var tempImage1 = base64Decode(dataJadwal![0]["Image"].toString().replaceAll("data:image/jpeg;base64,", ""));
                      // var tempImage2 = base64Decode(File(value!.path).readAsStringSync());
                      File? imageFile;
                      imageFile = File(value!.path);
                      if (imageFile != null) {
                        final bites = imageFile.readAsBytesSync();
                        image2.bitmap = base64Encode(bites);
                        image2.imageType = Regula.ImageType.PRINTED;
                      }

                      image1.bitmap = base64Encode(tempImage1);
                      image1.imageType = Regula.ImageType.PRINTED;
                      

                      matchFaces("in");
                  });
                    // Regula.FaceSDK.presentFaceCaptureActivity().then((result) async {
                    //   var response = Regula.FaceCaptureResponse.fromJson(json.decode(result))!;
                    //   if (response.image != null && response.image!.bitmap != null){
                    //     showLoadingDialog(context, _keyLoader, info: "Begin Scaning");

                    //     // var img1 = Image.memory(dataJadwal![0]["Image"]);
                    //     var tempImage1 = base64Decode(dataJadwal![0]["Image"].toString().replaceAll("data:image/jpeg;base64,", ""));
                    //     var tempImage2 = base64Decode(response.image!.bitmap!.replaceAll("\n", ""));
                    //     // var img2 = Image.memory(tempImage2);

                    //     image1.bitmap = base64Encode(tempImage1);
                    //     image1.imageType = Regula.ImageType.PRINTED;
                    //     image2.bitmap = base64Encode(tempImage2);
                    //     image2.imageType = Regula.ImageType.LIVE;
                    //     setState(() {
                          
                    //     });


                    //     // print(image1.bitmap);
                    //     await matchFaces("in");

                    //   }
                    // });

                    // if(isMatch){
                    //   Navigator.of(context, rootNavigator: true).pop();
                    //   messageBox(context: context, title: "info", message: "Face Match");
                    // }
                    // else{
                    //   print("emty object");
                    // }
                  },
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(
                  this.widget.sess.width * 2,
                  this.widget.sess.width * 2,
                  this.widget.sess.width * 2,
                  this.widget.sess.width * 2),
              child: Container(
                width: this.widget.sess.width * 40,
                child: ElevatedButton(
                  child: Text("Check Out"),
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      )),
                      backgroundColor: MaterialStateProperty.all(Colors.red)),
                  onPressed: dataAbsen!.length == 0 ? null : dataAbsen![0]["ImageOUT"] != "" ? null : () async{
                    showLoadingDialog(context, _keyLoader, info: "Begin Scaning");
                    _getCurrentPosition();
                    final ImagePicker _picker = ImagePicker();

                    await _picker.pickImage(
                      source: ImageSource.camera, 
                      maxHeight: 600,
                      preferredCameraDevice: CameraDevice.front
                    ).then((value) {
                      // showLoadingDialog(context, _keyLoader, info: "Begin Scaning");

                      var tempImage1 = base64Decode(dataJadwal![0]["Image"].toString().replaceAll("data:image/jpeg;base64,", ""));
                      // var tempImage2 = base64Decode(File(value!.path).readAsStringSync());
                      File? imageFile;
                      imageFile = File(value!.path);
                      if (imageFile != null) {
                        final bites = imageFile.readAsBytesSync();
                        image2.bitmap = base64Encode(bites);
                        image2.imageType = Regula.ImageType.PRINTED;
                      }

                      image1.bitmap = base64Encode(tempImage1);
                      image1.imageType = Regula.ImageType.PRINTED;
                      

                      matchFaces("out");
                  });
                    // Regula.FaceSDK.presentFaceCaptureActivity().then((result) async {
                    //   var response = Regula.FaceCaptureResponse.fromJson(json.decode(result))!;
                    //   if (response.image != null && response.image!.bitmap != null){
                    //     showLoadingDialog(context, _keyLoader, info: "Begin Scaning");

                    //     // var img1 = Image.memory(dataJadwal![0]["Image"]);
                    //     var tempImage1 = base64Decode(dataJadwal![0]["Image"].toString().replaceAll("data:image/jpeg;base64,", ""));
                    //     var tempImage2 = base64Decode(response.image!.bitmap!.replaceAll("\n", ""));
                    //     // var img2 = Image.memory(tempImage2);

                    //     image1.bitmap = base64Encode(tempImage1);
                    //     image1.imageType = Regula.ImageType.PRINTED;
                    //     image2.bitmap = base64Encode(tempImage2);
                    //     image2.imageType = Regula.ImageType.LIVE;
                    //     setState(() {
                          
                    //     });

                    //     await matchFaces("out");

                    //   }
                    // });
                  },
                ),
              ),
            )
          ],
        ) : Container(
          child: Align(
            alignment: Alignment.center,
            child: Text("Karyawan Tidak ada jadwal"),
          ),
        ),
      ),
      body: dataJadwal!.length > 0 ? Column(
        children: [
          Padding(
            padding: EdgeInsets.all(this.widget.sess.width * 2),
            child: Container(
              width: double.infinity,
              height: this.widget.sess.hight * 11,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 1),
                      Container(
                          width: this.widget.sess.width * 30,
                          height: this.widget.sess.hight * 10,
                          child: Center(
                            child: Text(
                              dataJadwal!.length == 0 ? "" : "Shift : " + dataJadwal![0]["NamaShift"].toString().toUpperCase(),
                              style: TextStyle(
                                  fontSize: this.widget.sess.width * 4,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          decoration: new BoxDecoration(
                            borderRadius: new BorderRadius.circular(10.0),
                            color: Theme.of(context).primaryColor,
                          )),
                    ],
                  ),
                  Padding(
                      padding: EdgeInsets.all(this.widget.sess.width * 2),
                      child: Container(
                        width: this.widget.sess.width * 50,
                        height: this.widget.sess.hight * 10,
                        alignment: Alignment.topLeft,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                this.widget.sess.KodeUser,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: this.widget.sess.width * 4,
                                    color: Theme.of(context).primaryColor),
                              ),
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                this.widget.sess.NamaUser,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: this.widget.sess.width * 5,
                                    color: Theme.of(context).primaryColor),
                              ),
                            ),
                          ],
                        ),
                      ))
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(this.widget.sess.width * 2),
            child: Container(
              width: double.infinity,
              height: this.widget.sess.hight * 30,
              // color: Colors.amber,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: this.widget.sess.width * 40,
                    height: this.widget.sess.hight * 30,
                    // color: Colors.black,
                    child: dataAbsen!.length > 0 ? dataAbsen![0]["ImageIN"] == "" ? Image.asset("assets/portrait.png") : Image.network(this.widget.sess.server + "Assets/images/Absensi/" + dataAbsen![0]["ImageIN"]) : Image.asset("assets/portrait.png"),
                    // child: dataAbsen!.length == 0 ? Image.asset("assets/portrait.png") : Image.memory(jsonDecode(image1.bitmap.toString())),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: this.widget.sess.width * 2,
                        right: this.widget.sess.width * 2),
                    child: Container(
                        width: this.widget.sess.width * 50,
                        height: this.widget.sess.hight * 30,
                        // color: Colors.blue,
                        child: Column(
                          children: [
                            Table(
                              columnWidths: {
                                0: FlexColumnWidth(this.widget.sess.width * 25),
                                1: FlexColumnWidth(this.widget.sess.width * 2),
                                2: FlexColumnWidth(this.widget.sess.width * 35)
                              },
                              // border: TableBorder.all(color: Colors.green, width: 1.5),
                              children: [
                                TableRow(
                                  children: [
                                    Text(
                                      "NIK",
                                      style: TextStyle( fontSize: this.widget.sess.width * 4),
                                    ),
                                    Text(":",
                                      style: TextStyle( fontSize:this.widget.sess.width * 4)
                                    ),
                                    Text(this.widget.sess.KodeUser,style: TextStyle(fontSize: this.widget.sess.width * 4)
                                    )
                                  ]
                                ),
                                TableRow(children: [
                                  Text("Nama",
                                      style: TextStyle(
                                          fontSize:
                                              this.widget.sess.width * 4)),
                                  Text(":",
                                      style: TextStyle(
                                          fontSize:
                                              this.widget.sess.width * 4)),
                                  Text(this.widget.sess.NamaUser,
                                      style: TextStyle(
                                          fontSize: this.widget.sess.width * 4))
                                ]),
                                TableRow(children: [
                                  Text("Tanggal",
                                      style: TextStyle(
                                          fontSize:
                                              this.widget.sess.width * 4)),
                                  Text(":",
                                      style: TextStyle(
                                          fontSize:
                                              this.widget.sess.width * 4)),
                                  Text(dataAbsen!.length == 0 ? "" : dataAbsen![0]["Checkin"].toString().split(" ")[0],
                                      style: TextStyle(
                                          fontSize: this.widget.sess.width * 4))
                                ]),
                                TableRow(children: [
                                  Text("Jam",
                                      style: TextStyle(
                                          fontSize:
                                              this.widget.sess.width * 4)),
                                  Text(":",
                                      style: TextStyle(
                                          fontSize:
                                              this.widget.sess.width * 4)),
                                  Text(dataAbsen!.length == 0 ? "" : dataAbsen![0]["Checkin"].toString().split(" ")[1].split(".")[0],
                                      style: TextStyle(
                                          fontSize: this.widget.sess.width * 4))
                                ])
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                left: this.widget.sess.width * 2,
                                right: this.widget.sess.width * 2,
                                top: this.widget.sess.width * 2,
                              ),
                              child: Container(
                                width: this.widget.sess.width * 55,
                                height: this.widget.sess.hight * 10,
                                // color: Colors.black,
                                child: Center(
                                  child: Text(
                                    dataAbsen!.length > 0 ? "CHECKIN" : "",
                                    style: TextStyle(
                                        fontSize: this.widget.sess.width * 8,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green),
                                  ),
                                ),
                              ),
                            )
                          ],
                        )),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(this.widget.sess.width * 2),
            child: Container(
              width: double.infinity,
              height: this.widget.sess.hight * 30,
              // color: Colors.amber,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: this.widget.sess.width * 40,
                    height: this.widget.sess.hight * 30,
                    // color: Colors.black,
                    child: dataAbsen!.length > 0 ? dataAbsen![0]["ImageOUT"] == "" ? Image.asset("assets/portrait.png") : Image.network(this.widget.sess.server + "Assets/images/Absensi/" + dataAbsen![0]["ImageOUT"]):Image.asset("assets/portrait.png") ,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: this.widget.sess.width * 2,
                        right: this.widget.sess.width * 2),
                    child: Container(
                        width: this.widget.sess.width * 50,
                        height: this.widget.sess.hight * 30,
                        // color: Colors.blue,
                        child: Column(
                          children: [
                            Table(
                              columnWidths: {
                                0: FlexColumnWidth(this.widget.sess.width * 25),
                                1: FlexColumnWidth(this.widget.sess.width * 2),
                                2: FlexColumnWidth(this.widget.sess.width * 35)
                              },
                              // border: TableBorder.all(color: Colors.green, width: 1.5),
                              children: [
                                TableRow(children: [
                                  Text(
                                    "NIK",
                                    style: TextStyle(
                                        fontSize: this.widget.sess.width * 4),
                                  ),
                                  Text(":",
                                      style: TextStyle(
                                          fontSize:
                                              this.widget.sess.width * 4)),
                                  Text(this.widget.sess.KodeUser,
                                      style: TextStyle(
                                          fontSize: this.widget.sess.width * 4))
                                ]),
                                TableRow(children: [
                                  Text("Nama",
                                      style: TextStyle(
                                          fontSize:
                                              this.widget.sess.width * 4)),
                                  Text(":",
                                      style: TextStyle(
                                          fontSize:
                                              this.widget.sess.width * 4)),
                                  Text(this.widget.sess.NamaUser,
                                      style: TextStyle(
                                          fontSize: this.widget.sess.width * 4))
                                ]),
                                TableRow(children: [
                                  Text("Tanggal",
                                      style: TextStyle(
                                          fontSize:
                                              this.widget.sess.width * 4)),
                                  Text(":",
                                      style: TextStyle(
                                          fontSize:
                                              this.widget.sess.width * 4)),
                                  Text(dataAbsen!.length > 0 ? dataAbsen![0]["CheckOut"].toString() == "0000-00-00 00:00:00.000000" ? "" : dataAbsen![0]["CheckOut"].toString().split(" ")[0] :"",
                                      style: TextStyle(
                                          fontSize: this.widget.sess.width * 4))
                                ]),
                                TableRow(children: [
                                  Text("Jam",
                                      style: TextStyle(
                                          fontSize:
                                              this.widget.sess.width * 4)),
                                  Text(":",
                                      style: TextStyle(
                                          fontSize:
                                              this.widget.sess.width * 4)),
                                  Text(dataAbsen!.length > 0 ? dataAbsen![0]["CheckOut"].toString() == "0000-00-00 00:00:00.000000" ? "" : dataAbsen![0]["CheckOut"].toString().split(" ")[1].split(".")[0]:"",
                                      style: TextStyle(
                                          fontSize: this.widget.sess.width * 4))
                                ])
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                left: this.widget.sess.width * 2,
                                right: this.widget.sess.width * 2,
                                top: this.widget.sess.width * 2,
                              ),
                              child: Container(
                                width: this.widget.sess.width * 55,
                                height: this.widget.sess.hight * 10,
                                // color: Colors.black,
                                child: Center(
                                  child: Text(
                                    dataAbsen!.length > 0 ?dataAbsen![0]["CheckOut"].toString() != "0000-00-00 00:00:00.000000" ? "CHECKOUT" : "" : "",
                                    style: TextStyle(
                                        fontSize: this.widget.sess.width * 8,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red),
                                  ),
                                ),
                              ),
                            )
                          ],
                        )),
                  )
                ],
              ),
            ),
          )
        ],
      ) : Container(
        child: Align(
          alignment: Alignment.center,
          child: Text("Karyawan Tidak ada jadwal"),
        ),
      )
    );
  }
}
