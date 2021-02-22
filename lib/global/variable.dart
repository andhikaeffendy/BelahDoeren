import 'package:belah_duren/model/branch.dart';
import 'package:belah_duren/model/member_level.dart';
import 'package:belah_duren/model/user.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

String domain = "http://belahdoeren.wiradipa.com/";
String api_url = domain+"/api/v1/";

User currentUser;
Items selectedBranch;
Position currentPosition;
String selectedOrderType = "pickup";

showCircular(context){
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return new Center(
          child: new CircularProgressIndicator(),
        );
      }
  );
}

alertDialog(context, title, message){
  showDialog(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          title: Text(title),
          content: Text(message),
        );
      }
  );
}

nextPage(context, page) async {
  return Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => page),
  );
}

startNewPage(context, page){
  Navigator.pushAndRemoveUntil(
      context,
      new MaterialPageRoute(
        builder: (context) => page,
      ), (route) => false);
}
