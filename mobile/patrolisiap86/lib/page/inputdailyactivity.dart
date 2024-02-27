import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:mobilepatrol/general/dialog.dart';
import 'package:mobilepatrol/general/session.dart';
import 'package:mobilepatrol/models/base64converter.dart';
import 'package:mobilepatrol/models/dailyactivity.dart';
import 'package:mobilepatrol/models/guestlog.dart';

class InputDailyActivity extends StatefulWidget {
  final session sess;
  final int iddata;
  InputDailyActivity(this.sess, {this.iddata = -1});

  @override
  _InputInputDailyActivityState createState() =>
      _InputInputDailyActivityState();
}

class _InputInputDailyActivityState extends State<InputDailyActivity> {
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  final ImagePicker _picker = ImagePicker();

  File? imageFile1;
  List? pathext1;
  String? extentionPath1;
  String image641 = "";
  String linkImage1 = "";

  File? imageFile2;
  List? pathext2;
  String? extentionPath2;
  String image642 = "";
  String linkImage2 = "";

  File? imageFile3;
  List? pathext3;
  String? extentionPath3;
  String image643 = "";
  String linkImage3 = "";

  TextEditingController _Tanggal = TextEditingController();
  TextEditingController _Keterangan = TextEditingController();

  String _formatedTanggal = "";
  String _RawTanggal = "";

  DateTime selectedTanggal = DateTime.now();

  List? _dataDailyActivity;

  _selectTanggal(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedTanggal,
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedTanggal)
      setState(() {
        selectedTanggal = picked.toLocal();
        //print(selectedDate);
        _Tanggal.text = selectedTanggal.toString();
      });
  }

  Future<Map> _getData() async {
    Map oParam() {
      return {
        "id": this.widget.iddata.toString(),
        "KodeLokasi": this.widget.sess.LocationID.toString(),
        "RecordOwnerID": this.widget.sess.RecordOwnerID
      };
    }

    return Mod_DailyActivity(this.widget.sess, Parameter: oParam()).Find();
  }

  Future<String> convertBase64(String ImageLink) async {
    return Base64Converter(ImageLink).networkImageToBase64();
  }

  _fetchData() async {
    var temp = await _getData();

    _dataDailyActivity = temp["data"];

    if (_dataDailyActivity!.length > 0) {
      var imgBase64Str1;
      var imgBase64Str2;
      var imgBase64Str3;

      if(_dataDailyActivity![0]["Gambar1"] != null){
        if(_dataDailyActivity![0]["Gambar1"] != ""){
          imgBase64Str1 = await Base64Converter(this.widget.sess.server + "Assets/images/activity/" + _dataDailyActivity![0]["Gambar1"]).networkImageToBase64();
        }
      }

      if(_dataDailyActivity![0]["Gambar2"] != null){
        if(_dataDailyActivity![0]["Gambar2"] != ""){
          imgBase64Str2 = await Base64Converter(this.widget.sess.server + "Assets/images/activity/" + _dataDailyActivity![0]["Gambar2"]).networkImageToBase64();
        }
      }

      if(_dataDailyActivity![0]["Gambar3"] != null){
        if(_dataDailyActivity![0]["Gambar3"] != ""){
          imgBase64Str3 = await Base64Converter(this.widget.sess.server + "Assets/images/activity/" + _dataDailyActivity![0]["Gambar3"]).networkImageToBase64();
        }
      }

      setState(() {
        _formatedTanggal = DateFormat('yyyy-MM-dd').format(DateTime.parse(_dataDailyActivity![0]["Tanggal"]));
        _RawTanggal = DateFormat('dd-MM-yyyy').format(DateTime.parse(_dataDailyActivity![0]["Tanggal"]));

        _Tanggal.text = _RawTanggal;
        _Keterangan.text = _dataDailyActivity![0]["DeskripsiAktifitas"];

        linkImage1 = _dataDailyActivity![0]["Gambar1"] == null ? "" : _dataDailyActivity![0]["Gambar1"] == "" ? "" : this.widget.sess.server + "Assets/images/activity/" + _dataDailyActivity![0]["Gambar1"];
        linkImage2 = _dataDailyActivity![0]["Gambar2"] == null ? "" : _dataDailyActivity![0]["Gambar2"] == "" ? "" : this.widget.sess.server + "Assets/images/activity/" + _dataDailyActivity![0]["Gambar2"];
        linkImage3 = _dataDailyActivity![0]["Gambar3"] == null ? "" : _dataDailyActivity![0]["Gambar3"] == "" ? "" : this.widget.sess.server + "Assets/images/activity/" + _dataDailyActivity![0]["Gambar3"];

        image641 = imgBase64Str1 == null ? "" :imgBase64Str1;
        image642 = imgBase64Str2 == null ? "" :imgBase64Str2;
        image643 = imgBase64Str3 == null ? "" :imgBase64Str3;

      });

    }
  }

  @override
  void initState() {
    _fetchData();
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
        title: Text(
          "Input Daily Activity",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: ListView(
        children: [
          _InputTanggal(),
          _InputKeterangan(),
          _Gambar(),
          _inputData()
        ],
      ),
    );
  }

  Widget _InputTanggal(){
    return Padding(
      padding: EdgeInsets.only(
        top: this.widget.sess.width * 2,
        left: this.widget.sess.width * 2,
        right: this.widget.sess.width * 2
      ),
      child: ExpansionTile(
        title: Text("Tanggal"),
        initiallyExpanded: true,
        collapsedBackgroundColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        children: [
          TextField(
            controller: _Tanggal,
            decoration: InputDecoration(
              icon: Icon(Icons.calendar_today,
                  size: this.widget.sess!.hight * 4,
                  color: Theme.of(context).primaryColor),
              labelText: "dd/mm/yyyy",
              labelStyle: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: this.widget.sess!.hight * 2,
              ),
            ),
            textInputAction: TextInputAction.next,
            readOnly: true,
            onTap: () async {
              DateTime? pickDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1945),
                lastDate: DateTime(2100),
              );

              if (pickDate != null) {
                setState(() {
                  _formatedTanggal =DateFormat('yyyy-MM-dd').format(pickDate);
                  _RawTanggal =DateFormat('dd-MM-yyyy').format(pickDate);

                  _Tanggal.text = _RawTanggal;
                });
              }
            },
          )
        ],
      ),
    );
  }

  Widget _InputKeterangan(){
    return Padding(
      padding: EdgeInsets.only(
        top: this.widget.sess.width * 2,
        left: this.widget.sess.width * 2,
        right: this.widget.sess.width * 2
      ),
      child: ExpansionTile(
        title: Text("Deskripsi Pekerjaan"),
        initiallyExpanded: true,
        collapsedBackgroundColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        children: [
          TextField(
            controller: _Keterangan,
            decoration: InputDecoration(
              icon: Icon(Icons.read_more_rounded,
                  size: this.widget.sess.hight * 4,
                  color: Theme.of(context).primaryColor),
              labelStyle: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: this.widget.sess.hight * 2,
              ),
            ),
            textInputAction: TextInputAction.next,
            maxLines: 4,
            // readOnly: true,
          )
        ],
      ),
    );
  }

  Widget _Gambar(){
    return Padding(
      padding: EdgeInsets.only(
        top: this.widget.sess.width * 2,
        left: this.widget.sess.width * 2,
        right: this.widget.sess.width * 2
      ),
      child: ExpansionTile(
        title: Text("Lampirkan Foto"),
        initiallyExpanded: true,
        collapsedBackgroundColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        children: [
          Container(
            width: double.infinity,
            height: this.widget.sess.hight * 25,
            // color: Colors.amber,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  child: Container(
                    width: this.widget.sess.width *30,
                    height: this.widget.sess.hight * 20,
                    // color: Colors.black,
                    child: Card(
                      child: linkImage1 == "" ? 
                        imageFile1 != null ? Image.file(File(imageFile1!.path)) :
                        Icon(Icons.image) : Image.network(linkImage1),
                    ),
                  ),
                  onTap: () async{
                    final ImagePicker _picker = ImagePicker();

                    await _picker.pickImage(
                      source: ImageSource.camera, 
                      maxHeight: 600,
                      preferredCameraDevice: CameraDevice.front
                    ).then((value) {
                        setState(() {
                          imageFile1 = File(value!.path);
                          pathext1 = imageFile1!.uri.toString().split("/");
                          extentionPath1 = pathext1![pathext1!.length - 1].toString();

                          if (imageFile1 != null) {
                            final bites = imageFile1!.readAsBytesSync();
                            image641 = base64Encode(bites);
                          }
                        });
                      }
                    );
                  },
                ),
                SizedBox(
                  width: this.widget.sess.width * 2,
                ),
                GestureDetector(
                  child: Container(
                    width: this.widget.sess.width *30,
                    height: this.widget.sess.hight * 20,
                    child: Card(
                      child: linkImage2 == "" ?  
                      imageFile2 != null ? Image.file(File(imageFile2!.path)) :
                      Icon(Icons.image) : Image.network(linkImage2),
                    ),
                  ),
                  onTap: ()async{
                    final ImagePicker _picker = ImagePicker();

                    await _picker.pickImage(
                      source: ImageSource.camera, 
                      maxHeight: 600,
                      preferredCameraDevice: CameraDevice.front
                    ).then((value) {
                        setState(() {
                          imageFile2 = File(value!.path);
                          pathext2 = imageFile2!.uri.toString().split("/");
                          extentionPath2 = pathext2![pathext2!.length - 1].toString();

                          if (imageFile2 != null) {
                            final bites = imageFile2!.readAsBytesSync();
                            image642 = base64Encode(bites);
                          }
                        });
                      }
                    );
                  },
                ),
                SizedBox(
                  width: this.widget.sess.width * 2,
                ),
                GestureDetector(
                  child: Container(
                    width: this.widget.sess.width *30,
                    height: this.widget.sess.hight * 20,
                    child: Card(
                      child: linkImage3 == "" ?  
                      imageFile3 != null ? Image.file(File(imageFile3!.path)) :
                      Icon(Icons.image) : Image.network(linkImage3),
                    ),
                  ),
                  onTap: ()async{
                    final ImagePicker _picker = ImagePicker();

                    await _picker.pickImage(
                      source: ImageSource.camera, 
                      maxHeight: 600,
                      preferredCameraDevice: CameraDevice.front
                    ).then((value) {
                        setState(() {
                          imageFile3 = File(value!.path);
                          pathext3 = imageFile3!.uri.toString().split("/");
                          extentionPath3 = pathext3![pathext3!.length - 1].toString();

                          if (imageFile3 != null) {
                            final bites = imageFile3!.readAsBytesSync();
                            image643 = base64Encode(bites);
                          }
                        });
                      }
                    );
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _inputData(){
    return Padding(
      padding: EdgeInsets.only(
        left: this.widget.sess.width * 2,
        right: this.widget.sess.width * 2,
        top: this.widget.sess.width * 1,
        bottom: this.widget.sess.hight * 2,
      ),
      child: Container(
        width: double.infinity,
        height: this.widget.sess.hight * 5,
        // color: Colors.amberAccent,
        child: ElevatedButton(
          child: Text(
            "Simpan Data",
            style: TextStyle(
              color: Colors.white
            ),
          ),
          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0),)),
            backgroundColor: MaterialStateProperty.all(Theme.of(context).primaryColor)
          ),
          
          onPressed: ()async{
            showLoadingDialog(context, _keyLoader, info: "Begin Login");
            DateTime nowJam = DateTime.now();
            Map<String, String> dataParam = {
              "id" : this.widget.iddata != -1 ? this.widget.iddata.toString() : "-1",
              "Tanggal" : _formatedTanggal + " " + nowJam.hour.toString() + ":"+nowJam.minute.toString(),
              "RecordOwnerID" : this.widget.sess.RecordOwnerID,
              "LocationID" : this.widget.sess.LocationID.toString(),
              "DeskripsiAktifitas" : _Keterangan.text,
              "KodeKaryawan" : this.widget.sess.KodeUser,
              "formtype" : this.widget.iddata != -1 ? "edit" : "add"
            };

            if (image641 != "") {
              dataParam.addAll({"Gambar1":image641});
              // dataParam().putIfAbsent("TglMasuk", () => _formatedTglMasuk);
            }
            if (image642 != "") {
              dataParam.addAll({"Gambar2":image642});
              // dataParam().putIfAbsent("TglMasuk", () => _formatedTglMasuk);
            }
            if (image643 != "") {
              dataParam.addAll({"Gambar3":image643});
              // dataParam().putIfAbsent("TglMasuk", () => _formatedTglMasuk);
            }

            var oSave = Mod_DailyActivity(this.widget.sess, Parameter: dataParam).Append().then((value) async {
              if (value["success"]) {
                Navigator.of(context, rootNavigator: true).pop();
                Navigator.of(context).pop();
              } else {
                Navigator.of(context, rootNavigator: true).pop();
                await messageBox(context: context,title: "Infomasi",message: value["message"]);
              }
            });
          },
        ),
      ),
    );
  }

}
