import 'package:flutter/material.dart';
import 'package:mobilepatrol/general/dialog.dart';
import 'package:mobilepatrol/general/session.dart';
import 'package:mobilepatrol/models/shift.dart';

Future<bool> checkSchadule(session sess, BuildContext context)async{
  String nowDate = DateTime.now().year.toString() + "-" + DateTime.now().month.toString() + "-" + DateTime.now().day.toString();
    Map oParam(){
      return {
        'TglAwal'       : nowDate ,
        'TglAkhir'      : nowDate,
        'id'            : '',
        'RecordOwnerID' : sess.RecordOwnerID,
        'NIK'           : sess.KodeUser
      };
    }

    var temp = await Mod_Shift(sess, oParam()).getJadwal();
    if(temp["data"].length > 0){
      return true;
    }
    else{
      return false;
    }
    // .then((value) => {
    //   if(value["data"].length == 0){
    //     messageDialog(context: context, title: "Validation", message: "Jadwal Belum dibuat")
    //   }
    // });
}