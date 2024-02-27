import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobilepatrol/general/session.dart';
import 'package:mobilepatrol/models/guestlog.dart';
import 'package:mobilepatrol/page/inputguestlog.dart';

class GuestLog extends StatefulWidget {
  final session sess;
  GuestLog(this.sess);

  @override
  _GuestLogState createState() => _GuestLogState();
}

class _GuestLogState extends State<GuestLog> {
  TextEditingController _TglAwal = TextEditingController();
  TextEditingController _TglAkhir = TextEditingController();

  String _formatedTglAwal = "";
  String _formatedTglAkhir = "";

  String _RawTglAwal = "";
  String _RawTglAkhir = "";

  DateTime selectedTglAwal = DateTime.now();
  DateTime selectedTglAkhir = DateTime.now();

  List? _dateGuestLog;

  _selectTglAwal(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedTglAwal)
      setState(() {
        selectedTglAwal = picked.toLocal();
        //print(selectedDate);
        _TglAwal.text = selectedTglAwal.toString();
      });
  }

  _selectTglAkhir(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedTglAkhir)
      setState(() {
        selectedTglAkhir = picked.toLocal();
        //print(selectedDate);
        _TglAkhir.text = selectedTglAkhir.toString();
      });
  }

  Future<Map> _getDataGuestLog(String TglAwal, String TglAkhir) async {
    Map oParam() {
      return {
        "TglAwal": TglAwal,
        "TglAkhir": TglAkhir,
        "KodeLokasi": this.widget.sess.LocationID.toString(),
        "RecordOwnerID": this.widget.sess.RecordOwnerID
      };
    }

    return Mod_GuestLog(this.widget.sess, Parameter: oParam()).ReadGuestLog();
  }

  _fetchDataGuestLog(String TglAwal, String TglAkhir) async {
    var temp = await _getDataGuestLog(TglAwal, TglAkhir);
    // print(temp["data"]);
    _dateGuestLog = temp["data"];
    setState(() {
      
    });
  }

  Future _refreshData() async {
    setState(() {});

    Completer<Null> completer = Completer<Null>();
    Future.delayed(Duration(seconds: 1)).then((_) {
      completer.complete();
    });
    return completer.future;
  }

  @override
  void initState() {
    _TglAwal.text = DateFormat('dd-MM-yyyy').format(DateTime.now());
    _TglAkhir.text = DateFormat('dd-MM-yyyy').format(DateTime.now());

    _formatedTglAwal = DateFormat('yyyy-MM-dd').format(DateTime.now());
    _formatedTglAkhir = DateFormat('yyyy-MM-dd').format(DateTime.now());
    _fetchDataGuestLog(_formatedTglAwal,_formatedTglAkhir);
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
          "Pencatatan Tamu",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () async{
          await Navigator.push(context,MaterialPageRoute(builder: (context) => InputGuestLog(this.widget.sess!))).then((value) {
            _fetchDataGuestLog(_formatedTglAwal,_formatedTglAkhir);
          });
        },
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
                left: this.widget.sess.width * 2,
                right: this.widget.sess.width * 2,
                top: this.widget.sess.width * 5),
            child: Container(
              width: double.infinity,
              height: this.widget.sess.hight * 15,
              // color: Colors.amber,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: this.widget.sess.width * 45,
                    height: this.widget.sess.hight * 15,
                    // color: Colors.black,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Tanggal Awal :",
                        ),
                        SizedBox(
                          height: this.widget.sess.hight * 2,
                        ),
                        TextField(
                          controller: _TglAwal,
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
                                _formatedTglAwal =
                                    DateFormat('yyyy-MM-dd').format(pickDate);
                                _RawTglAwal =
                                    DateFormat('dd-MM-yyyy').format(pickDate);

                                _TglAwal.text = _RawTglAwal;
                              });
                            }
                          },
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: this.widget.sess.width * 2,
                  ),
                  Container(
                      width: this.widget.sess.width * 45,
                      height: this.widget.sess.hight * 15,
                      // color: Colors.black,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Tanggal Akhir :",
                          ),
                          SizedBox(
                            height: this.widget.sess.hight * 2,
                          ),
                          TextField(
                            controller: _TglAkhir,
                            decoration: InputDecoration(
                              icon: Icon(Icons.calendar_today,
                                  size: this.widget.sess.hight * 4,
                                  color: Theme.of(context).primaryColor),
                              labelText: "dd/mm/yyyy",
                              labelStyle: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: this.widget.sess.hight * 2,
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
                                  _formatedTglAkhir =
                                      DateFormat('yyyy-MM-dd').format(pickDate);
                                  _RawTglAkhir =
                                      DateFormat('dd-MM-yyyy').format(pickDate);

                                  _TglAkhir.text = _RawTglAkhir;
                                });
                              }
                            },
                          )
                        ],
                      ))
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                left: this.widget.sess.width * 2,
                right: this.widget.sess.width * 2,
                top: this.widget.sess.width * 1),
            child: Container(
              width: double.infinity,
              height: this.widget.sess.hight * 5,
              // color: Colors.amberAccent,
              child: ElevatedButton(
                child: Text(
                  "Refresh Data",
                  style: TextStyle(color: Colors.white),
                ),
                style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    )),
                    backgroundColor: MaterialStateProperty.all(
                        Theme.of(context).primaryColor)),
                onPressed: () {
                  _fetchDataGuestLog(_formatedTglAwal,_formatedTglAkhir);
                },
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: this.widget.sess.hight * 2,
              left: this.widget.sess.hight * 2,
              right: this.widget.sess.hight * 2,
            ),
            child: RefreshIndicator(
              onRefresh: () => _refreshData(),
              child: Container(
                width: double.infinity,
                height: this.widget.sess.hight * 63,
                // color: Colors.amber,
                child: ListView.builder(
                    itemCount: _dateGuestLog == null ? 0 : _dateGuestLog!.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          title: Text(
                            _dateGuestLog![index]["NamaTamu"] + " >> " + _dateGuestLog![index]["NamaYangDicari"],
                            style: TextStyle(
                              fontSize: this.widget.sess.width * 5,
                              fontFamily: "Arial",
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          subtitle: Text("Tanggal Kunjung : " + DateFormat('dd-MM-yy').format(DateTime.parse(_dateGuestLog![index]["Tanggal"] ))),
                          leading: CircleAvatar(
                            child: Text((index + 1).toString()),
                          ),
                          trailing: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                _dateGuestLog![index]["TglMasuk"] == null ? ">> " : ">> " + DateFormat('HH:mm').format(DateTime.parse(_dateGuestLog![index]["TglMasuk"] )),
                                style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: _dateGuestLog![index]["TglMasuk"] != null ? FontWeight.bold : FontWeight.normal
                                ),
                              ),
                              Text(
                                _dateGuestLog![index]["TglKeluar"] == null ? "<< 00:00" : "<< " + DateFormat('HH:mm').format(DateTime.parse(_dateGuestLog![index]["TglKeluar"] )),
                                style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: _dateGuestLog![index]["TglKeluar"] != null ? FontWeight.bold : FontWeight.normal
                                ),
                              )
                            ],
                          ),
                          onTap: () async{
                            await Navigator.push(context,MaterialPageRoute(builder: (context) => InputGuestLog(this.widget.sess, iddata: int.parse(_dateGuestLog![index]["id"]),))).then((value) {
                              _fetchDataGuestLog(_formatedTglAwal,_formatedTglAkhir);
                            });
                          },
                        ),
                      );
                    }),
              ),
            ),
          )
        ],
      ),
    );
  }
}
