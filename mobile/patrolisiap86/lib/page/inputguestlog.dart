import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:mobilepatrol/general/dialog.dart';
import 'package:mobilepatrol/general/session.dart';
import 'package:mobilepatrol/models/base64converter.dart';
import 'package:mobilepatrol/models/guestlog.dart';

class InputGuestLog extends StatefulWidget {
  final session sess;
  final int iddata;
  InputGuestLog(this.sess, {this.iddata = -1});

  @override
  _InputGuestLogState createState() => _InputGuestLogState();
}

class _InputGuestLogState extends State<InputGuestLog> {
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  final ImagePicker _picker = ImagePicker();

  File? imageFileMasuk;
  List? pathextMasuk;
  String? extentionPathMasuk;
  String image64Masuk = "";
  String linkImageMasuk = "";

  File? imageFileKeluar;
  List? pathextKeluar;
  String? extentionPathKeluar;
  String image64Keluar = "";
  String linkImageKeluar = "";

  TextEditingController _Tanggal = TextEditingController();
  TextEditingController _TglMasuk = TextEditingController();
  TextEditingController _TglKeluar = TextEditingController();
  TextEditingController _NamaTamu = TextEditingController();
  TextEditingController _NamaYangDiCari = TextEditingController();
  TextEditingController _TujuanTamu = TextEditingController();
  TextEditingController _Keterangan = TextEditingController();

  String _formatedTanggal = "";
  String _formatedTglMasuk = "";
  String _formatedTglKeluar = "";

  String _RawTanggal = "";
  String _RawTglMasuk = "";
  String _RawTglKeluar = "";

  DateTime selectedTanggal = DateTime.now();
  DateTime selectedTglMasuk = DateTime.now();
  DateTime selectedTglKeluar = DateTime.now();

  TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00);

  List ? _dateGuestLog;

  Future<Null> _selectTimeMasuk(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null)
      setState(() {
        selectedTime = picked;
        _formatedTglMasuk += " " +selectedTime.hour.toString() +":" +selectedTime.minute.toString();
        _RawTglMasuk += " " +selectedTime.hour.toString() +":" + selectedTime.minute.toString();
        _TglMasuk.text = _RawTglMasuk;
      });
  }

  Future<Null> _selectTimeKeluar(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null)
      setState(() {
        selectedTime = picked;

        _formatedTglKeluar += " " + selectedTime.hour.toString() + ":" + selectedTime.minute.toString(); _RawTglKeluar += " " + selectedTime.hour.toString() + ":" +selectedTime.minute.toString();
      });
  }

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

  _selectTanggalMasuk(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedTglMasuk,
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedTglMasuk)
      setState(() {
        selectedTglMasuk = picked.toLocal();
        //print(selectedDate);
        _TglMasuk.text = selectedTglMasuk.toString();
      });
  }

  _selectTanggalKeluar(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedTglKeluar,
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedTglKeluar)
      setState(() {
        selectedTglKeluar = picked.toLocal();
        //print(selectedDate);
        _TglKeluar.text = selectedTglKeluar.toString();
      });
  }

  Future<Map> _getDataGuestLog() async {
    Map oParam() {
      return {
        "id": this.widget.iddata.toString(),
        "KodeLokasi": this.widget.sess.LocationID.toString(),
        "RecordOwnerID": this.widget.sess.RecordOwnerID
      };
    }

    return Mod_GuestLog(this.widget.sess, Parameter: oParam()).FindGuestLog();
  }

  Future<String> convertBase64(String ImageLink) async{
    return Base64Converter(ImageLink).networkImageToBase64();
  }

  _fetchDataGuestLog() async {
    var temp = await _getDataGuestLog();
    // print(temp["data"]);
    _dateGuestLog = temp["data"];
    
    if (_dateGuestLog!.length > 0){
      var imgBase64StrIn;
      var imgBase64StrOut;

      if(_dateGuestLog![0]["ImageIn"] != null){
        if(_dateGuestLog![0]["ImageIn"] != ""){
          imgBase64StrIn = await Base64Converter(this.widget.sess.server + "Assets/images/guestlog/" + _dateGuestLog![0]["ImageIn"]).networkImageToBase64();
        }
      }

      if(_dateGuestLog![0]["ImageOut"] != null){
        if(_dateGuestLog![0]["ImageOut"] != ""){
          imgBase64StrOut = await Base64Converter(this.widget.sess.server + "Assets/images/guestlog/" + _dateGuestLog![0]["ImageOut"]).networkImageToBase64();
        }
      }
      // final imgBase64Str = await Base64Converter(_dateGuestLog![0]["ImageOut"]).networkImageToBase64;
      // print(imgBase64Str);
      setState(() {
        _formatedTanggal = DateFormat('yyyy-MM-dd').format(DateTime.parse(_dateGuestLog![0]["Tanggal"]));
        _RawTanggal = DateFormat('dd-MM-yyyy').format(DateTime.parse(_dateGuestLog![0]["Tanggal"]));

        _formatedTglMasuk = _dateGuestLog![0]["TglMasuk"] == null ? "" : DateFormat('yyyy-MM-dd HH:mm').format(DateTime.parse(_dateGuestLog![0]["TglMasuk"]));
        _RawTglMasuk = _dateGuestLog![0]["TglMasuk"] == null ? "" : DateFormat('dd-MM-yyyy HH:mm').format(DateTime.parse(_dateGuestLog![0]["TglMasuk"]));

        _formatedTglKeluar = _dateGuestLog![0]["TglKeluar"] == null ? "" : DateFormat('yyyy-MM-dd HH:mm').format(DateTime.parse(_dateGuestLog![0]["TglKeluar"]));
        _RawTglKeluar = _dateGuestLog![0]["TglKeluar"] == null ? "" : DateFormat('dd-MM-yyyy HH:mm').format(DateTime.parse(_dateGuestLog![0]["TglKeluar"]));

        _Tanggal.text = _RawTanggal;
        _TglMasuk.text = _RawTglMasuk;
        _TglKeluar.text =  _dateGuestLog![0]["TglKeluar"] == "0000-00-00 00:00:00" ? "" :_RawTglKeluar;
        linkImageMasuk = _dateGuestLog![0]["ImageIn"] == null ? "" : _dateGuestLog![0]["ImageIn"] == "" ? "" : this.widget.sess.server + "Assets/images/guestlog/" + _dateGuestLog![0]["ImageIn"];
        linkImageKeluar = _dateGuestLog![0]["ImageOut"] == null ? "" : _dateGuestLog![0]["ImageOut"] == "" ? "" : this.widget.sess.server + "Assets/images/guestlog/" + _dateGuestLog![0]["ImageOut"];
        _Keterangan.text = _dateGuestLog![0]["Keterangan"] == null ? "" :_dateGuestLog![0]["Keterangan"];
        _NamaTamu.text = _dateGuestLog![0]["NamaTamu"] == null ? "" :_dateGuestLog![0]["NamaTamu"];
        _NamaYangDiCari.text = _dateGuestLog![0]["NamaYangDicari"] == null ? "" :_dateGuestLog![0]["NamaYangDicari"];
        _TujuanTamu.text = _dateGuestLog![0]["Tujuan"] == null ? "" :_dateGuestLog![0]["Tujuan"];

        image64Masuk = imgBase64StrIn == null ? "" :imgBase64StrIn;
        image64Keluar = imgBase64StrOut == null ? "" :imgBase64StrOut;
      });
    }
  }

  @override
  void initState() {
    _fetchDataGuestLog();
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
          "Pencatatan Tamu - Tambah data",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: ListView(
        children: [
          _InputTanggal(),
          _InputNamaTamu(),
          _InputYangDisari(),
          _InputTujuan(),
          Padding(
            padding: EdgeInsets.all(this.widget.sess.width * 2),
            child: Container(
              width: double.infinity,
              height: this.widget.sess.hight * 50,
              // color:  Colors.amber,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: this.widget.sess.width * 45,
                    height: this.widget.sess.hight * 50,
                    // color: Colors.black,
                    child: _InputTanggalMasuk(),
                  ),
                  SizedBox(
                    width: this.widget.sess.width * 2,
                  ),
                  Container(
                    width: this.widget.sess.width * 45,
                    height: this.widget.sess.hight * 50,
                    // color: Colors.black,
                    child: _InputTanggalKeluar(),
                  )
                ],
              ),
            ),
          ),
          _InputKeterangan(),
          _inputData(),
          // _InputTanggalMasuk(),
          // _InputTanggalKeluar()
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

  Widget _InputNamaTamu(){
    return Padding(
      padding: EdgeInsets.only(
        top: this.widget.sess.width * 2,
        left: this.widget.sess.width * 2,
        right: this.widget.sess.width * 2
      ),
      child: ExpansionTile(
        title: Text("Nama Tamu"),
        initiallyExpanded: true,
        collapsedBackgroundColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        children: [
          TextField(
            controller: _NamaTamu,
            decoration: InputDecoration(
              icon: Icon(Icons.person_2,
                  size: this.widget.sess.hight * 4,
                  color: Theme.of(context).primaryColor),
              labelStyle: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: this.widget.sess.hight * 2,
              ),
            ),
            textInputAction: TextInputAction.next,
            // readOnly: true,
          )
        ],
      ),
    );
  }

  Widget _InputYangDisari(){
    return Padding(
      padding: EdgeInsets.only(
        top: this.widget.sess.width * 2,
        left: this.widget.sess.width * 2,
        right: this.widget.sess.width * 2
      ),
      child: ExpansionTile(
        title: Text("Nama Yang Dicari"),
        initiallyExpanded: true,
        collapsedBackgroundColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        children: [
          TextField(
            controller: _NamaYangDiCari,
            decoration: InputDecoration(
              icon: Icon(Icons.person_pin_circle_outlined,
                  size: this.widget.sess.hight * 4,
                  color: Theme.of(context).primaryColor),
              labelStyle: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: this.widget.sess.hight * 2,
              ),
            ),
            textInputAction: TextInputAction.next,
            // readOnly: true,
          )
        ],
      ),
    );
  }

  Widget _InputTujuan(){
    return Padding(
      padding: EdgeInsets.only(
        top: this.widget.sess.width * 2,
        left: this.widget.sess.width * 2,
        right: this.widget.sess.width * 2
      ),
      child: ExpansionTile(
        title: Text("Tujuan"),
        initiallyExpanded: true,
        collapsedBackgroundColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        children: [
          TextField(
            controller: _TujuanTamu,
            decoration: InputDecoration(
              icon: Icon(Icons.description,
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

  Widget _InputKeterangan(){
    return Padding(
      padding: EdgeInsets.only(
        top: this.widget.sess.width * 2,
        left: this.widget.sess.width * 2,
        right: this.widget.sess.width * 2
      ),
      child: ExpansionTile(
        title: Text("Keterangan"),
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

  Widget _InputTanggalMasuk(){
    return Padding(
      padding: EdgeInsets.only(
        top: this.widget.sess.width * 2
      ),
      child: ExpansionTile(
        title: Text("Tanggal Masuk"),
        initiallyExpanded: true,
        collapsedBackgroundColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        children: [
          TextField(
            controller: _TglMasuk,
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

                final TimeOfDay? pickedTime = await showTimePicker(
                  context: context,
                  initialTime: selectedTime,
                );

                DateTime _FixDate = DateTime(pickDate.year, pickDate.month, pickDate.day, pickedTime!.hour, pickedTime.minute);

                setState(() {
                  _formatedTglMasuk =DateFormat('yyyy-MM-dd HH:mm').format(_FixDate);
                  _RawTglMasuk =DateFormat('dd-MM-yyyy HH:mm').format(_FixDate);

                  _TglMasuk.text = _RawTglMasuk;
                });

                // _selectTimeMasuk(context);
              }
            },
          ),
          SizedBox(
            height: this.widget.sess.hight * 2,
          ),
          Container(
            width: this.widget.sess.width * 45,
            height: this.widget.sess.hight * 30,
            // color: Colors.amber,
            child: GestureDetector(
              child: Card(
                child: imageFileMasuk == null ? linkImageMasuk != "" ? Image.network(linkImageMasuk) : Image.asset("assets/portrait.png") :
                linkImageMasuk == "" ?
                Card(
                    child: Padding(
                    padding: EdgeInsets.all(this.widget.sess.width * 2),
                    child: Image.file(File(imageFileMasuk!.path)),
                  )
                ) : Image.network(linkImageMasuk),
              ),
              onTap: ()async{
                final ImagePicker _picker = ImagePicker();

                  await _picker.pickImage(
                    source: ImageSource.camera, 
                    maxHeight: 600,
                    preferredCameraDevice: CameraDevice.front
                  ).then((value) {
                    setState(() {
                      imageFileMasuk = File(value!.path);
                      pathextMasuk = imageFileMasuk!.uri.toString().split("/");
                      extentionPathMasuk = pathextMasuk![pathextMasuk!.length - 1].toString();

                      if (imageFileMasuk != null) {
                        final bites = imageFileMasuk!.readAsBytesSync();
                        image64Masuk = base64Encode(bites);
                      }
                    });
                  }
                );
              },
            )
            
          )
        ],
      ),
    );
  }

  Widget _InputTanggalKeluar(){
    return Padding(
      padding: EdgeInsets.only(
        top: this.widget.sess.width * 2,
      ),
      child: ExpansionTile(
        title: Text("Tanggal Keluar"),
        initiallyExpanded: true,
        collapsedBackgroundColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        children: [
          TextField(
            controller: _TglKeluar,
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

                final TimeOfDay? pickedTime = await showTimePicker(
                  context: context,
                  initialTime: selectedTime,
                );

                DateTime _FixDate = DateTime(pickDate.year, pickDate.month, pickDate.day, pickedTime!.hour, pickedTime.minute);

                setState(() {
                  _formatedTglKeluar =DateFormat('yyyy-MM-dd HH:mm').format(_FixDate);
                  _RawTglKeluar =DateFormat('dd-MM-yyyy HH:mm').format(_FixDate);

                  _TglKeluar.text = _RawTglKeluar;
                });

                // _selectTimeMasuk(context);
              }
            },
          ),
          SizedBox(
            height: this.widget.sess.hight * 2,
          ),
          Container(
            width: this.widget.sess.width * 45,
            height: this.widget.sess.hight * 30,
            // color: Colors.amber,
            child: GestureDetector(
              child: Card(
                child: imageFileKeluar == null ? linkImageKeluar != "" ? Image.network(linkImageKeluar) : Image.asset("assets/portrait.png") :
                linkImageKeluar == "" ?
                Card(
                    child: Padding(
                    padding: EdgeInsets.all(this.widget.sess.width * 2),
                    child: Image.file(File(imageFileKeluar!.path)),
                  )
                ): Image.network(linkImageKeluar),
              ),
              onTap: ()async{
                final ImagePicker _picker = ImagePicker();

                  await _picker.pickImage(
                    source: ImageSource.camera, 
                    maxHeight: 600,
                    preferredCameraDevice: CameraDevice.front
                  ).then((value) {
                    setState(() {
                      imageFileKeluar = File(value!.path);
                      pathextKeluar = imageFileKeluar!.uri.toString().split("/");
                      extentionPathKeluar = pathextKeluar![pathextKeluar!.length - 1].toString();

                      if (imageFileKeluar != null) {
                        final bites = imageFileKeluar!.readAsBytesSync();
                        image64Keluar = base64Encode(bites);
                      }
                    });
                  }
                );
              },
            )
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
            "Simpan Data Tamu",
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
            Map<String, String> dataParam = {
              "id" : this.widget.iddata != -1 ? this.widget.iddata.toString() : "-1",
              "Tanggal" : _formatedTanggal,
              // "TglMasuk" : _formatedTglMasuk ,
              // "TglKeluar" : _formatedTglKeluar ,
              // "ImageIn" : image64Masuk.toString(),
              // "ImageOut" : image64Keluar.toString(),
              "RecordOwnerID" : this.widget.sess.RecordOwnerID,
              "LocationID" : this.widget.sess.LocationID.toString(),
              "Keterangan" : _Keterangan.text,
              "NamaTamu" : _NamaTamu.text,
              "NamaYangDicari" : _NamaYangDiCari.text,
              "Tujuan" : _TujuanTamu.text,
              "formtype" : this.widget.iddata != -1 ? "edit" : "add"
            };
            // Map<String, String> dataParam(){
            //   return {
            //     "id" : this.widget.iddata != -1 ? this.widget.iddata.toString() : "-1",
            //     "Tanggal" : _formatedTanggal,
            //     // "TglMasuk" : _formatedTglMasuk ,
            //     // "TglKeluar" : _formatedTglKeluar ,
            //     // "ImageIn" : image64Masuk.toString(),
            //     // "ImageOut" : image64Keluar.toString(),
            //     "RecordOwnerID" : this.widget.sess.RecordOwnerID,
            //     "LocationID" : this.widget.sess.LocationID.toString(),
            //     "Keterangan" : _Keterangan.text,
            //     "NamaTamu" : _NamaTamu.text,
            //     "NamaYangDicari" : _NamaYangDiCari.text,
            //     "Tujuan" : _TujuanTamu.text,
            //     "formtype" : this.widget.iddata != -1 ? "edit" : "add"
            //   };
            // }
            
            if (_formatedTglMasuk != "") {
              dataParam.addAll({"TglMasuk":_formatedTglMasuk});
              // dataParam().putIfAbsent("TglMasuk", () => _formatedTglMasuk);
            }

            if(_formatedTglKeluar != ""){
              // dataParam().putIfAbsent("TglMasuk", () => _formatedTglKeluar);
              dataParam.addAll({"TglKeluar":_formatedTglKeluar});
            }

            if(image64Masuk != ""){
              // dataParam().putIfAbsent("ImageIn", () => image64Masuk);
              dataParam.addAll({"ImageIn":image64Masuk});
            }

            if(image64Keluar != ""){
              // dataParam().putIfAbsent("ImageOut", () => image64Keluar);
              dataParam.addAll({"ImageOut":image64Keluar});
            }

            print(dataParam.toString());
            var oSave = Mod_GuestLog(this.widget.sess, Parameter: dataParam).AppendGuestLog().then((value) async {
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
